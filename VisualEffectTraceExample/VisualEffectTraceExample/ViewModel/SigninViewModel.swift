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
    // メールアドレスの入力をViewModelへ伝える
    var inputMailAddressTrigger: PublishSubject<String> { get }

    // パスワードの入力をViewModelへ伝える
    var inputRawPasswordTrigger: PublishSubject<String> { get }

    // サインイン処理の実行をViewModelへ伝える
    var executeSigninRequestTrigger: PublishSubject<Void> { get }

    // APIRequestStateを元に戻す処理の実行をViewModelへ伝える
    var undoAPIRequestStateTrigger: PublishSubject<Void> { get }
}

protocol SigninViewModelOutputs {
    // メールアドレスの入力結果を格納する
    var mailAddress: Observable<String> { get }

    // パスワードの入力結果を格納する
    var rawPassword: Observable<String> { get }

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

    // MARK: - Properties (for SigninViewModelInputs)

    let inputMailAddressTrigger: PublishSubject<String> = PublishSubject<String>()

    let inputRawPasswordTrigger: PublishSubject<String> = PublishSubject<String>()
    
    let executeSigninRequestTrigger: PublishSubject<Void> = PublishSubject<Void>()

    let undoAPIRequestStateTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for SigninViewModelOutputs)

    var mailAddress: Observable<String> {
        return _mailAddress.asObservable()
    }

    var rawPassword: Observable<String> {
        return _rawPassword.asObservable()
    }

    var requestStatus: Observable<APIRequestState> {
        return _requestStatus.asObservable()
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: 中継地点となるBehaviorRelayの変数（Outputの変数を生成するための「つなぎ」のような役割）
    // → BehaviorRelayの変化が起こったらObservableに変換されてOutputに流れてくる
    private let _mailAddress: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private let _rawPassword: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: このViewModelで利用するRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "ApplicationUserRepository")) private var applicationUserRepository: ApplicationUserRepository
    @Dependencies.Inject(Dependencies.Name(rawValue: "SigninRepository")) private var signinRepository: SigninRepository

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        inputMailAddressTrigger
            .subscribe(
                onNext: { [weak self] mailAddress in
                    guard let self = self else { return }
                    self._mailAddress.accept(mailAddress)
                }
            )
            .disposed(by: disposeBag)
        inputRawPasswordTrigger
            .subscribe(
                onNext: { [weak self] rawPassword in
                    guard let self = self else { return }
                    self._rawPassword.accept(rawPassword)
                }
            )
            .disposed(by: disposeBag)
        executeSigninRequestTrigger
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self.executeSigninRequest(mailAddress: self._mailAddress.value, rawPassword: self._rawPassword.value)
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

    private func executeSigninRequest(mailAddress: String, rawPassword: String) {
        _requestStatus.accept(.requesting)
        signinRepository.requestSignin(mailAddress: mailAddress, rawPassword: rawPassword)
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    // MEMO: JsonAccessTokenを保存する
                    self.saveJsonWebToken(token: data.token)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }

    private func saveJsonWebToken(token: String) {
        applicationUserRepository.updateJsonAccessToken(token)
    }
}
