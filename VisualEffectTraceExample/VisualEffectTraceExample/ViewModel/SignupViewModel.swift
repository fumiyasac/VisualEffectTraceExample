//
//  SignupViewModel.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SignupViewModelInputs {
    // ユーザーネームの入力をViewModelへ伝える
    var inputUserNameTrigger: PublishSubject<String> { get }

    // メールアドレスの入力をViewModelへ伝える
    var inputMailAddressTrigger: PublishSubject<String> { get }

    // パスワードの入力をViewModelへ伝える
    var inputRawPasswordTrigger: PublishSubject<String> { get }

    // サインアップ処理の実行をViewModelへ伝える
    var executeSignupRequestTrigger: PublishSubject<Void> { get }
}

protocol SignupViewModelOutputs {
    // ユーザーネームの入力結果を格納する
    var userName: Observable<String> { get }

    // メールアドレスの入力結果を格納する
    var mailAddress: Observable<String> { get }

    // パスワードの入力結果を格納する
    var rawPassword: Observable<String> { get }

    // サインアップ処理の実行結果を格納する
    var requestStatus: Observable<APIRequestState> { get }
}

protocol SignupViewModelType {
    var inputs: SignupViewModelInputs  { get }
    var outputs: SignupViewModelOutputs { get }
}

final class SignupViewModel: SignupViewModelInputs, SignupViewModelOutputs, SignupViewModelType {

    var inputs: SignupViewModelInputs { return self }
    var outputs: SignupViewModelOutputs { return self }

    // MARK: - Properties (for SignupViewModelInputs)

    let inputUserNameTrigger: PublishSubject<String> = PublishSubject<String>()

    let inputMailAddressTrigger: PublishSubject<String> = PublishSubject<String>()

    let inputRawPasswordTrigger: PublishSubject<String> = PublishSubject<String>()

    let executeSignupRequestTrigger: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Properties (for SignupViewModelOutputs)

    var userName: Observable<String> {
        return _userName.asObservable()
    }

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
    private let _userName: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private let _mailAddress: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private let _rawPassword: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private let _requestStatus: BehaviorRelay<APIRequestState> = BehaviorRelay<APIRequestState>(value: .none)

    // MEMO: このViewModelで利用するUseCase(Domain Model)
    @Dependencies.Inject(Dependencies.Name(rawValue: "SignupUsecase")) private var signupUseCase: SignupUsecase

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        inputUserNameTrigger
            .subscribe(
                onNext: { [weak self] userName in
                    guard let self = self else { return }
                    self._userName.accept(userName)
                }
            )
            .disposed(by: disposeBag)
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
        executeSignupRequestTrigger
            .subscribe(
                onNext: { [weak self] in
                    guard let self = self else { return }
                    self.executeSignupRequest(userName: self._userName.value, mailAddress: self._mailAddress.value, rawPassword: self._rawPassword.value)
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func executeSignupRequest(userName: String, mailAddress: String, rawPassword: String) {
        _requestStatus.accept(.requesting)
        signupUseCase.execute(userName: userName, mailAddress: mailAddress, rawPassword: rawPassword)
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                    // MEMO: サインアップ完了後に_requestStatusの値を元に戻す
                    self._requestStatus.accept(.none)
                },
                onFailure: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                    // MEMO: サインアップ完了後に_requestStatusの値を元に戻す
                    self._requestStatus.accept(.none)
                }
            )
            .disposed(by: disposeBag)
    }
}
