//
//  EventIntroductionViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/30.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol EventIntroductionViewModelInputs {

    // 初回のデータ取得をViewModelへ伝える
    var initialFetchTrigger: PublishSubject<Void> { get }

    // ページネーション実行時のデータ取得をViewModelへ伝える
    var paginationFetchTrigger: PublishSubject<Void> { get }

    // PullToRefreshでのデータ更新をViewModelへ伝える
    var pullToRefreshTrigger: PublishSubject<Void> { get }

    // APIRequestStateを元に戻す処理の実行をViewModelへ伝える
    var undoAPIRequestStateTrigger: PublishSubject<Void> { get }
}

protocol EventIntroductionViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var eventIntroductionItems: Observable<Array<EventIntroductionEntity>> { get }

    // 取得処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
}

protocol EventIntroductionViewModelType {
    var inputs: EventIntroductionViewModelInputs  { get }
    var outputs: EventIntroductionViewModelOutputs { get }
}

final class EventIntroductionViewModel: EventIntroductionViewModelInputs, EventIntroductionViewModelOutputs, EventIntroductionViewModelType {

    var inputs: EventIntroductionViewModelInputs { return self }
    var outputs: EventIntroductionViewModelOutputs { return self }

    // MARK: - Properties (for EventIntroductionViewModelInputs)

    let initialFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let paginationFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let pullToRefreshTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let undoAPIRequestStateTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for EventIntroductionViewModelOutputs)

    var eventIntroductionItems: Observable<Array<EventIntroductionEntity>> {
        return _eventIntroductionItems.asObservable()
    }

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _eventIntroductionItems: BehaviorRelay<Array<EventIntroductionEntity>> = BehaviorRelay<Array<EventIntroductionEntity>>(value: [])
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: ページネーションに利用する変数（ぶっちゃけBehaviorRelayにする必要はあまりなさそうに思う）
    private let _nextPage: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
    private let _hasNextPage: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)

    // MEMO: このViewModelで利用するRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "EventIntroductionRepository")) private var eventIntroductionRepository: EventIntroductionRepository

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        initialFetchTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeEventIntroductionDataRequest(page: 1)
                }
            )
            .disposed(by: disposeBag)
        paginationFetchTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    if self._hasNextPage.value {
                        self.executeEventIntroductionDataRequest(page: self._nextPage.value, ignoreError: true)
                    }
                }
            )
            .disposed(by: disposeBag)
        pullToRefreshTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    // MEMO: ページネーションに利用する変数を初期状態にする
                    self._nextPage.accept(1)
                    self._hasNextPage.accept(true)
                    self._eventIntroductionItems.accept([])
                    self.executeEventIntroductionDataRequest(page: 1)
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

    private func executeEventIntroductionDataRequest(page: Int, ignoreError: Bool = false) {
        _requestStatus.accept(.requesting)
        eventIntroductionRepository.requestEventIntroductionDataList(page: page)
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)

                    // MEMO: API通信のレスポンスから取得した値を加工して反映する
                    self._nextPage.accept(data.currentPage + 1)
                    self._hasNextPage.accept(data.hasNextPage)

                    // MEMO: データ自体は一意な配列になっている（既に表示しているものが取得できた場合には先に表示されているものに対して、後で取得したデータに同一なものがある場合は後の内容を反映する）
                    let oldResult = self._eventIntroductionItems.value
                    let newResult = data.result
                    let result = UniqueDataArrayBuilder.fillDifferenceOfOldAndNewLists(EventIntroductionEntity.self, oldDataArray: oldResult, newDataArray: newResult)
                    self._eventIntroductionItems.accept(result)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    // MEMO: paginationFetchTriggerを発火させる場合はエラー画面を表示する必要がないので(ignoreError = true)としている。
                    self._requestStatus.accept(ignoreError ? .none : .error)
                }
            )
            .disposed(by: disposeBag)
    }
}
