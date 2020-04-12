//
//  SignupScreenActionCreator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

struct SignupScreenActionCreator {}

extension SignupScreenActionCreator {

    static func inputUserName(targetText: String) {
        appStore.dispatch(SignupScreenState.SignupScreenAction.changeUserNameInput(targetText: targetText))
    }

    static func inputMailAddress(targetText: String) {
        appStore.dispatch(SignupScreenState.SignupScreenAction.changeMailAddressInput(targetText: targetText))
    }

    static func inputRawPassword(targetText: String) {
        appStore.dispatch(SignupScreenState.SignupScreenAction.changeRawPasswordInput(targetText: targetText))
    }

    static func changeStateToProcessingSignup() {
        appStore.dispatch(SignupScreenState.SignupScreenAction.isProcessingSignupRequest)
    }

    static func changeStateToSignupSuccess() {
        appStore.dispatch(SignupScreenState.SignupScreenAction.becomeSignupRequestSuccess)
    }

    static func changeStateToSignupError() {
        appStore.dispatch(SignupScreenState.SignupScreenAction.becomeSignupRequestError)
    }

    static func changeStateToSignupNormal() {
        appStore.dispatch(SignupScreenState.SignupScreenAction.becomeSignupRequestNormal)
    }

    static func changeStateToInitial() {
        appStore.dispatch(SignupScreenState.SignupScreenAction.restoreInitialState)
    }
}
