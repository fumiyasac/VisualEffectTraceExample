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
}

protocol AnnouncementViewModelOutputs {

    // JSONから取得した表示用データを格納する
    var announcementItems: Observable<Array<AnnouncementEntity>> { get }

    // サインイン処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
}

protocol AnnouncementViewModelModelType {
    var inputs: AnnouncementViewModelInputs  { get }
    var outputs: AnnouncementViewModelOutputs { get }
}

final class AnnouncementViewModel: AnnouncementViewModelInputs, AnnouncementViewModelOutputs, AnnouncementViewModelModelType {

    var inputs: AnnouncementViewModelInputs { return self }
    var outputs: AnnouncementViewModelOutputs { return self }

    // MARK: - Properties (for TutorialViewModelInputs)

    let initialFetchTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let pullToRefreshTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for TutorialViewModelOutputs)

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

    // MEMO: このViewModelで利用するUseCase(Domain Model)
    private let requestAnnouncementDataUseCase: AnnouncementUsecase

    // MARK: - Initializer

    init(requestAnnouncementDataUseCase: AnnouncementUsecase) {

        // AnnouncementUsecaseプロトコルを適合させるUserCaseをインスタンス経由で該当データを取得する
        self.requestAnnouncementDataUseCase = requestAnnouncementDataUseCase

        // ViewModel側の処理実行トリガーと連結させる
        initialFetchTrigger
            .subscribe(
                onNext: { [weak self] signinPatameters in
                    guard let self = self else { return }
                    self.executeAnnouncementDataRequest()
                }
            )
            .disposed(by: disposeBag)
        pullToRefreshTrigger
            .subscribe(
                onNext: { [weak self] signinPatameters in
                    guard let self = self else { return }
                    self.executeAnnouncementDataRequest()
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func executeAnnouncementDataRequest() {
        _requestStatus.accept(.requesting)
        requestAnnouncementDataUseCase.execute()
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    self._announcementItems.accept(data.result)
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}