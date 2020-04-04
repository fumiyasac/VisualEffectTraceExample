//
//  SigninScreenActionCreator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/04.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

struct SigninScreenActionCreator {}

extension SigninScreenActionCreator {

    static func inputMailAddress(targetText: String) {
        appStore.dispatch(SigninScreenState.SigninScreenAction.changeMailAddressInput(targetText: targetText))
    }

    static func inputRawPassword(targetText: String) {
        appStore.dispatch(SigninScreenState.SigninScreenAction.changeRawPasswordInput(targetText: targetText))
    }

    static func changeStateToProcessingLogin() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.isProcessingLoginRequest)
    }

    static func changeStateToLoginSuccess() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.becomeLoginRequestSuccess)
    }

    static func changeStateToLoginError() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.becomeLoginRequestError)
    }

    static func changeStateToInitial() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.restoreInitialState)
    }
}
