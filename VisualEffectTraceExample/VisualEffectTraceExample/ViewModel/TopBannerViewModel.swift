//
//  TopBannerViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/30.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TopBannerViewModelInputs {

    // 初回のデータ取得をViewModelへ伝える
    var initialFetchTrigger: PublishSubject<Void> { get }

    // PullToRefreshでのデータ更新をViewModelへ伝える
    var pullToRefreshTrigger: PublishSubject<Void> { get }

    // APIRequestStateを元に戻す処理の実行をViewModelへ伝える
    var undoAPIRequestStateTrigger: PublishSubject<Void> { get }
}

protocol TopBannerViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var topBannerItems: Observable<Array<TopBannerEntity>> { get }

    // 取得処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
}

protocol TopBannerViewModelType {
    var inputs: TopBannerViewModelInputs  { get }
    var outputs: TopBannerViewModelOutputs { get }
}

final class TopBannerViewModel: TopBannerViewModelInputs, TopBannerViewModelOutputs, TopBannerViewModelType {

    var inputs: TopBannerViewModelInputs { return self }
    var outputs: TopBannerViewModelOutputs { return self }

    // MARK: - Properties (for TopBannerViewModelInputs)

    let initialFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let pullToRefreshTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let undoAPIRequestStateTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for TopBannerViewModelOutputs)

    var topBannerItems: Observable<Array<TopBannerEntity>> {
        return _topBannerItems.asObservable()
    }

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _topBannerItems: BehaviorRelay<Array<TopBannerEntity>> = BehaviorRelay<Array<TopBannerEntity>>(value: [])
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: このViewModelで利用するRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "TopBannerRepository")) private var topBannerRepository: TopBannerRepository

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        initialFetchTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeTopBannerDataRequest()
                }
            )
            .disposed(by: disposeBag)
        pullToRefreshTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self._topBannerItems.accept([])
                    self.executeTopBannerDataRequest()
                }
            )
            .disposed(by: disposeBag)
        undoAPIRequestStateTrigger
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self._requestStatus.accept(.none)
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func executeTopBannerDataRequest() {
        _requestStatus.accept(.requesting)
        topBannerRepository.requestTopBannerDataList()
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    self._topBannerItems.accept(data.result)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
