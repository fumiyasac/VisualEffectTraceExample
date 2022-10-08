//
//  ItemsViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ItemsViewModelInputs {

    // 初回のデータ取得をViewModelへ伝える
    var initialFetchTrigger: PublishSubject<Void> { get }

    // ページネーション実行時のデータ取得をViewModelへ伝える
    var paginationFetchTrigger: PublishSubject<Void> { get }

    // PullToRefreshでのデータ更新をViewModelへ伝える
    var pullToRefreshTrigger: PublishSubject<Void> { get }
}

protocol ItemsViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var recentAnnouncement: Observable<AnnouncementEntity> { get }
    var items: Observable<Array<ItemEntity>> { get }

    // 取得処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
}

protocol ItemsViewModelType {
    var inputs: ItemsViewModelInputs  { get }
    var outputs: ItemsViewModelOutputs { get }
}

final class ItemsViewModel: ItemsViewModelInputs, ItemsViewModelOutputs, ItemsViewModelType {

    var inputs: ItemsViewModelInputs { return self }
    var outputs: ItemsViewModelOutputs { return self }

    // MARK: - Properties (for ItemsViewModelInputs)
    
    let initialFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let paginationFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let pullToRefreshTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for ItemsViewModelOutputs)

    var recentAnnouncement: Observable<AnnouncementEntity> {
        return _recentAnnouncement.compactMap { $0 }
    }

    var items: Observable<Array<ItemEntity>> {
        return _items.asObservable()
    }

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _recentAnnouncement: BehaviorRelay<AnnouncementEntity?> = BehaviorRelay<AnnouncementEntity?>(value: nil)
    private let _items: BehaviorRelay<Array<ItemEntity>> = BehaviorRelay<Array<ItemEntity>>(value: [])
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: ページネーションに利用する変数（ぶっちゃけBehaviorRelayにする必要はあまりなさそうに思う）
    private let _nextPage: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
    private let _hasNextPage: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)

    // MEMO: このViewModelで利用するRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "RecentAnnouncementRepository")) private var recentAnnouncementRepository: RecentAnnouncementRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "ItemRepository")) private var itemRepository: ItemRepository

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        initialFetchTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeRecentAnnouncementDataRequest()
                    self.executeItemDataRequest(page: 1)
                }
            )
            .disposed(by: disposeBag)
        paginationFetchTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    if self._hasNextPage.value {
                        self.executeItemDataRequest(page: self._nextPage.value)
                    }
                }
            )
            .disposed(by: disposeBag)
        pullToRefreshTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeRecentAnnouncementDataRequest()
                    // MEMO: ページネーションに利用する変数を初期状態にする
                    self._nextPage.accept(1)
                    self._hasNextPage.accept(true)
                    self._items.accept([])
                    self.executeItemDataRequest(page: 1)
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    // MEMO: requestStatusに関しては、.requestingとそれ以外(.successまたは.error)の場合で分ければ良い。
    // ※この画面に関してはPullToRefreshをして更新できる形である。

    private func executeRecentAnnouncementDataRequest() {
        _requestStatus.accept(.requesting)
        recentAnnouncementRepository.requestRecentAnnouncementData()
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    self._recentAnnouncement.accept(data.result)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }

    private func executeItemDataRequest(page: Int) {
        _requestStatus.accept(.requesting)
        itemRepository.requestItemDataList(page: page)
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)

                    // MEMO: API通信のレスポンスから取得した値を加工して反映する
                    self._nextPage.accept(data.currentPage + 1)
                    self._hasNextPage.accept(data.hasNextPage)

                    // MEMO: データ自体は一意な配列になっている（既に表示しているものが取得できた場合には先に表示されているものに対して、後で取得したデータに同一なものがある場合は後の内容を反映する）
                    let oldResult = self._items.value
                    let newResult = data.result
                    let result = UniqueDataArrayBuilder.fillDifferenceOfOldAndNewLists(ItemEntity.self, oldDataArray: oldResult, newDataArray: newResult)
                    self._items.accept(result)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
