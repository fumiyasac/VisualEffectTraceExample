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

    // PullToRefreshでのデータ更新をViewModelへ伝える
    var pullToRefreshTrigger: PublishSubject<Void> { get }
}

protocol ItemsViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var recentAnnouncement: Observable<AnnouncementEntity> { get }

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

    let pullToRefreshTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for ItemsViewModelOutputs)

    var recentAnnouncement: Observable<AnnouncementEntity> {
        return _recentAnnouncement.compactMap { $0 }
    }

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _recentAnnouncement: BehaviorRelay<AnnouncementEntity?> = BehaviorRelay<AnnouncementEntity?>(value: nil)
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: このViewModelで利用するUseCase(Domain Model)
    @Dependencies.Inject(Dependencies.Name(rawValue: "RecentAnnouncementUseCase")) private var recentAnnouncementUseCase: RecentAnnouncementUseCase

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        initialFetchTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeRecentAnnouncementDataRequest()
                }
            )
            .disposed(by: disposeBag)
        pullToRefreshTrigger
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeRecentAnnouncementDataRequest()
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func executeRecentAnnouncementDataRequest() {
        _requestStatus.accept(.requesting)
        recentAnnouncementUseCase.execute()
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    self._recentAnnouncement.accept(data.result)
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
