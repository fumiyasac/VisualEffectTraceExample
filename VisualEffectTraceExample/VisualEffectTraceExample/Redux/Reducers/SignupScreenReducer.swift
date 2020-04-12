//
//  SignupScreenReducer.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

struct SignupScreenReducer {}

extension SignupScreenReducer {

    // MARK: - Static Function

    static func reducer(action: ReSwift.Action, state: SignupScreenState?) -> SignupScreenState {

        var state = state ?? SignupScreenState()

        // MEMO: ユーザーの画面遷移を決定するためのアクションでない場合はStateの変更は許容しない
        guard let action = action as? SignupScreenState.SignupScreenAction else { return state }

        switch action {

        case let .changeUserNameInput(targetText):
                state.userName = targetText

        case let .changeMailAddressInput(targetText):
            state.mailAddress = targetText

        case let .changeRawPasswordInput(targetText):
            state.rawPassword = targetText

        case .isProcessingSignupRequest:
            state.isProcessionSignupRequest = true
            state.isSignupRequestSuccess = false
            state.isSignupRequestError = false

        case .becomeSignupRequestSuccess:
            state.isProcessionSignupRequest = false
            state.isSignupRequestSuccess = true
            state.isSignupRequestError = false

        case .becomeSignupRequestError:
            state.isProcessionSignupRequest = false
            state.isSignupRequestSuccess = false
            state.isSignupRequestError = true

        case .becomeSignupRequestNormal:
            state.isProcessionSignupRequest = false
            state.isSignupRequestSuccess = false
            state.isSignupRequestError = false

        case .restoreInitialState:
            state.userName = ""
            state.mailAddress = ""
            state.rawPassword = ""
            state.isProcessionSignupRequest = false
            state.isSignupRequestSuccess = false
            state.isSignupRequestError = false
        }

        // Debug.
        AppLogger.printMessageForDebug("SignupScreenStateが更新されました。")

        return state
    }
}
