//
//  MainViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/28.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainViewModelInputs {

    // 登録ユーザーの内部データ取得処理を実行する
    var initialSettingTrigger: PublishSubject<Void> { get }
}

protocol MainViewModelOutputs {

    // 現在の登録ユーザーの状態を返却する
    var targetApplicationUserState: Observable<ApplicationUserStatus> { get }
}

protocol MainViewModelType {
    var inputs: MainViewModelInputs  { get }
    var outputs: MainViewModelOutputs { get }
}

final class MainViewModel: MainViewModelInputs, MainViewModelOutputs, MainViewModelType {

    var inputs: MainViewModelInputs { return self }
    var outputs: MainViewModelOutputs { return self }

    // MARK: - Properties (for MainViewModelInputs)

    let initialSettingTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for MainViewModelOutputs)

    var targetApplicationUserState: Observable<ApplicationUserStatus> {
        return _targetApplicationUserState.compactMap { $0 }
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _targetApplicationUserState: BehaviorRelay<ApplicationUserStatus?> = BehaviorRelay<ApplicationUserStatus?>(value: nil)

    // MEMO: このViewModelで利用するRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "MainRepository")) private var mainRepository: MainRepository

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        initialSettingTrigger
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self.getApplicationUserStatus()
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func getApplicationUserStatus() {
        let applicationUserStatus = mainRepository.searchApplicationUserData()
        _targetApplicationUserState.accept(applicationUserStatus)
    }
}
