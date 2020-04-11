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

        case .isProcessingSigninRequest:
            state.isProcessionSigninRequest = true
            state.isSigninRequestSuccess = false
            state.isSigninRequestError = false

        case .becomeSigninRequestSuccess:
            state.isProcessionSigninRequest = false
            state.isSigninRequestSuccess = true
            state.isSigninRequestError = false

        case .becomeSigninRequestError:
            state.isProcessionSigninRequest = false
            state.isSigninRequestSuccess = false
            state.isSigninRequestError = true

        case .becomeSigninRequestNormal:
            state.isProcessionSigninRequest = false
            state.isSigninRequestSuccess = false
            state.isSigninRequestError = false

        case .restoreInitialState:
            state.mailAddress = ""
            state.rawPassword = ""
            state.isProcessionSigninRequest = false
            state.isSigninRequestSuccess = false
            state.isSigninRequestError = false
        }

        // Debug.
        AppLogger.printMessageForDebug("SigninScreenStateが更新されました。")

        return state
    }
}
