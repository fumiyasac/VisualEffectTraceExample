//
//  FeaturedArticleViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FeaturedArticleViewModelInputs {

    // 初回のデータ取得をViewModelへ伝える
    var initialFetchTrigger: PublishSubject<Void> { get }
}

protocol FeaturedArticleViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var featuredArticleItems: Observable<Array<FeaturedArticleEntity>> { get }

    // 取得処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
}

protocol FeaturedArticleViewModelType {
    var inputs: FeaturedArticleViewModelInputs { get }
    var outputs: FeaturedArticleViewModelOutputs { get }
}

final class FeaturedArticleViewModel: FeaturedArticleViewModelInputs, FeaturedArticleViewModelOutputs, FeaturedArticleViewModelType {

    var inputs: FeaturedArticleViewModelInputs { return self }
    var outputs: FeaturedArticleViewModelOutputs { return self }

    // MARK: - Properties (for TopBannerViewModelInputs)

    let initialFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let pullToRefreshTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for TopBannerViewModelOutputs)

    var featuredArticleItems: Observable<Array<FeaturedArticleEntity>> {
        return _featuredArticleItems.asObservable()
    }

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _featuredArticleItems: BehaviorRelay<Array<FeaturedArticleEntity>> = BehaviorRelay<Array<FeaturedArticleEntity>>(value: [])
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: このViewModelで利用するUseCase(Domain Model)
    @Dependencies.Inject(Dependencies.Name(rawValue: "FeaturedArticleUseCase")) private var featuredArticleUseCase: FeaturedArticleUseCase

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        initialFetchTrigger
            .subscribe(
                onNext: { [weak self] signinPatameters in
                    guard let self = self else { return }
                    self.executeFeaturedArticleDataRequest()
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func executeFeaturedArticleDataRequest() {
        _requestStatus.accept(.requesting)
        featuredArticleUseCase.execute()
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    self._featuredArticleItems.accept(data.result)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
