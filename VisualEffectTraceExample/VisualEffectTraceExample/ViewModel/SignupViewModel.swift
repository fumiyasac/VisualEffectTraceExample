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

    // サインアップ処理の実行をViewModelへ伝える
    var executeSignupRequestTrigger: PublishSubject<SignupViewModel.SignupPatameters> { get }
}

protocol SignupViewModelOutputs {

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

    // MARK: - Typealias

    typealias SignupPatameters = (targetUserName: String, targetMailAddress: String, targetRawPassword: String)

    // MARK: - Properties (for SigninViewModelInputs)

    let executeSignupRequestTrigger: PublishSubject<SignupViewModel.SignupPatameters> = PublishSubject<SignupViewModel.SignupPatameters>()

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
    @Dependencies.Inject(Dependencies.Name(rawValue: "SignupUsecase")) private var signupUseCase: SignupUsecase

    // MARK: - Initializer

    init() {

        // ViewModel側の処理実行トリガーと連結させる
        executeSignupRequestTrigger
            .subscribe(
                onNext: { [weak self] signupPatameters in
                    guard let self = self else { return }
                    self.executeSignupRequest(signupPatameters: signupPatameters)
                }
            )
            .disposed(by: disposeBag)
    }

    // MARK: - Private Function

    private func executeSignupRequest(signupPatameters: SignupPatameters) {
        _requestStatus.accept(.requesting)
        signupUseCase.execute(userName: signupPatameters.targetUserName, mailAddress: signupPatameters.targetMailAddress, rawPassword: signupPatameters.targetRawPassword)
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self._requestStatus.accept(.success)
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self._requestStatus.accept(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
