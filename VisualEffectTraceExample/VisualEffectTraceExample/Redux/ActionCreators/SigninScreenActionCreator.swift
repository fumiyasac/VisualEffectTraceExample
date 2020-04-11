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

    static func changeStateToProcessingSignin() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.isProcessingSigninRequest)
    }

    static func changeStateToSigninSuccess() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.becomeSigninRequestSuccess)
    }

    static func changeStateToSigninError() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.becomeSigninRequestError)
    }

    static func changeStateToSigninNormal() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.becomeSigninRequestNormal)
    }

    static func changeStateToInitial() {
        appStore.dispatch(SigninScreenState.SigninScreenAction.restoreInitialState)
    }
}
