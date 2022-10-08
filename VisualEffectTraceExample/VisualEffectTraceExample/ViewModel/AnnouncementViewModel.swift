//
//  AnnouncementViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/14.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AnnouncementViewModelInputs {

    // 初回のデータ取得をViewModelへ伝える
    var initialFetchTrigger: PublishSubject<Void> { get }

    // PullToRefreshでのデータ更新をViewModelへ伝える
    var pullToRefreshTrigger: PublishSubject<Void> { get }

    // APIRequestStateを元に戻す処理の実行をViewModelへ伝える
    var undoAPIRequestStateTrigger: PublishSubject<Void> { get }
}

protocol AnnouncementViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var announcementItems: Observable<Array<AnnouncementEntity>> { get }

    // 取得処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
}

protocol AnnouncementViewModelType {
    var inputs: AnnouncementViewModelInputs  { get }
    var outputs: AnnouncementViewModelOutputs { get }
}

final class AnnouncementViewModel: AnnouncementViewModelInputs, AnnouncementViewModelOutputs, AnnouncementViewModelType {

    var inputs: AnnouncementViewModelInputs { return self }
    var outputs: AnnouncementViewModelOutputs { return self }

    // MARK: - Properties (for AnnouncementViewModelInputs)

    let initialFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let pullToRefreshTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let undoAPIRequestStateTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for AnnouncementViewModelOutputs)

    var announcementItems: Observable<Array<AnnouncementEntity>> {
        return _announcementItems.asObservable()
    }

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _announcementItems: BehaviorRelay<Array<AnnouncementEntity>> = BehaviorRelay<Array<AnnouncementEntity>>(value: [])
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: このViewModelで利用するRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "AnnouncementRepository")) private var announcementRepository: AnnouncementRepository

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        initialFetchTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeAnnouncementDataRequest()
                }
            )
            .disposed(by: disposeBag)
        pullToRefreshTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeAnnouncementDataRequest()
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

    private func executeAnnouncementDataRequest() {
        _requestStatus.accept(.requesting)
        announcementRepository.requestAnnouncementDataList()
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    self._announcementItems.accept(data.result)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
