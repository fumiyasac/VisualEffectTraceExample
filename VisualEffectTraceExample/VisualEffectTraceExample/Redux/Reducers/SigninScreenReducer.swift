//
//  SigninScreenReducer.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/04.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

struct SigninScreenReducer {}

extension SigninScreenReducer {

    // MARK: - Static Function

    static func reducer(action: ReSwift.Action, state: SigninScreenState?) -> SigninScreenState {

        var state = state ?? SigninScreenState()

        // MEMO: ユーザーの画面遷移を決定するためのアクションでない場合はStateの変更は許容しない
        guard let action = action as? SigninScreenState.SigninScreenAction else { return state }

        switch action {

        case let .changeMailAddressInput(targetText):
            state.mailAddress = targetText

        case let .changeRawPasswordInput(targetText):
            state.rawPassword = targetText

        case .isProcessingLoginRequest:
            state.isProcessionLoginRequest = true
            state.isLoginRequestSuccess = false
            state.isLoginRequestError = false

        case .becomeLoginRequestSuccess:
            state.isProcessionLoginRequest = false
            state.isLoginRequestSuccess = true
            state.isLoginRequestError = false

        case .becomeLoginRequestError:
            state.isProcessionLoginRequest = false
            state.isLoginRequestSuccess = false
            state.isLoginRequestError = true
 
        case .restoreInitialState:
            state.mailAddress = ""
            state.rawPassword = ""
            state.isProcessionLoginRequest = false
            state.isLoginRequestSuccess = false
            state.isLoginRequestError = false
        }

    // Debug.
        AppLogger.printMessageForDebug("LoginScreenStateが更新されました。")

        return state
    }
}
