//
//  SigninViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/05.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SigninViewModelInputs {

    // ログイン処理の実行をViewModelへ伝える
    var executeSigninRequestTrigger: PublishSubject<SigninViewModel.SigninPatameters> { get }

    // ログイン処理時に取得したJsonWebTokenの保存をViewModelへ伝える
    var saveJsonWebTokenTrigger: PublishSubject<String> { get }
}

protocol SigninViewModelOutputs {

    // ログイン処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }

    // ログイン処理成功時に取得できるJsonWebToken格納する
    var returnedJsonWebToken: Observable<String> { get }
}

protocol SigninViewModelType {
    var inputs: SigninViewModelInputs  { get }
    var outputs: SigninViewModelOutputs { get }
}

final class SigninViewModel: SigninViewModelInputs, SigninViewModelOutputs, SigninViewModelType {

    var inputs: SigninViewModelInputs { return self }
    var outputs: SigninViewModelOutputs { return self }

    // MARK: - Typealias

    typealias SigninPatameters = (targetMailAddress: String, targetRawPassword: String)

    // MARK: - Properties (for SigninViewModelInputs)

    let executeSigninRequestTrigger: PublishSubject<SigninViewModel.SigninPatameters> = PublishSubject<SigninViewModel.SigninPatameters>()

    let saveJsonWebTokenTrigger: PublishSubject<String> = PublishSubject<String>()

    // MARK: - Properties (for SigninViewModelOutputs)

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    var returnedJsonWebToken: Observable<String> {
        return _returnedJsonWebToken
            .filter { $0 != nil }
            .map { $0! }
            .asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)
    private let _returnedJsonWebToken: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
}
