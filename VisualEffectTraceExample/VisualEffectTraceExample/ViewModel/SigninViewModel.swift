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

    // サインイン処理の実行をViewModelへ伝える
    var executeSigninRequestTrigger: PublishSubject<SigninViewModel.SigninPatameters> { get }
}

protocol SigninViewModelOutputs {

    // サインイン処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
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

    // MARK: - Properties (for SigninViewModelOutputs)

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: このViewModelで利用するUseCase(Domain Model)
    @Dependencies.Inject(Dependencies.Name(rawValue: "ApplicationUserStatusUseCase")) private var applicationUserStatusUseCase: ApplicationUserStatusUseCase
    @Dependencies.Inject(Dependencies.Name(rawValue: "SigninUsecase")) private var signinUsecase: SigninUsecase

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        executeSigninRequestTrigger
            .subscribe(
                onNext: { [weak self] signinPatameters in
                    guard let self = self else { return }
                    self.executeSigninRequest(signinPatameters: signinPatameters)
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func executeSigninRequest(signinPatameters: SigninPatameters) {
        _requestStatus.accept(.requesting)
        signinUsecase.execute(mailAddress: signinPatameters.targetMailAddress, rawPassword: signinPatameters.targetRawPassword)
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    // MEMO: JsonAccessTokenを保存する
                    self.saveJsonWebToken(token: data.token)
                    // MEMO: サインイン完了後に_requestStatusの値を元に戻す
                    self._requestStatus.accept(.none)
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                    // MEMO: サインイン完了後に_requestStatusの値を元に戻す
                    self._requestStatus.accept(.none)
                }
            )
            .disposed(by: disposeBag)
    }

    private func saveJsonWebToken(token: String) {
        applicationUserStatusUseCase.executeUpdateToken(token)
    }
}
