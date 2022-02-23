//
//  StoryViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol StoryViewModelInputs {

    // 初回のデータ取得をViewModelへ伝える
    var initialFetchTrigger: PublishSubject<Void> { get }
}

protocol StoryViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var storyItems: Observable<Array<StoryEntity>> { get }

    // 取得処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
}

protocol StoryViewModelType {
    var inputs: StoryViewModelInputs { get }
    var outputs: StoryViewModelOutputs { get }
}

final class StoryViewModel: StoryViewModelInputs, StoryViewModelOutputs, StoryViewModelType {

    var inputs: StoryViewModelInputs { return self }
    var outputs: StoryViewModelOutputs { return self }

    // MARK: - Properties (for TopBannerViewModelInputs)

    let initialFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for TopBannerViewModelOutputs)

    var storyItems: Observable<Array<StoryEntity>> {
        return _storyItems.asObservable()
    }

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _storyItems: BehaviorRelay<Array<StoryEntity>> = BehaviorRelay<Array<StoryEntity>>(value: [])
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: このViewModelで利用するUseCase(Domain Model)
    @Dependencies.Inject(Dependencies.Name(rawValue: "StoryUseCase")) private var storyUseCase: StoryUseCase

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        initialFetchTrigger
            .subscribe(
                onNext: { [weak self] signinPatameters in
                    guard let self = self else { return }
                    self.executeStoryDataRequest()
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func executeStoryDataRequest() {
        _requestStatus.accept(.requesting)
        storyUseCase.execute()
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    self._storyItems.accept(data.result)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
