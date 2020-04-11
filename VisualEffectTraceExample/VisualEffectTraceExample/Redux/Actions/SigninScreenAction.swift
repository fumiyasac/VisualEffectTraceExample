//
//  SigninScreenAction.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/04.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

extension SigninScreenState {

    // サインイン画面に関するstateを変更させるアクションをEnumで定義する
    enum SigninScreenAction: ReSwift.Action {

        // メールアドレス入力欄へ入力があった場合のアクション
        case changeMailAddressInput(targetText: String)

        // メールアドレス入力欄へ入力があった場合のアクション
        case changeRawPasswordInput(targetText: String)

        // サインイン処理中の場合のアクション
        case isProcessingSigninRequest

        // サインイン処理が成功した場合のアクション
        case becomeSigninRequestSuccess

        // サインイン処理が失敗した場合のアクション
        case becomeSigninRequestError

        // サインイン処理中状態を元に戻す場合のアクション
        case becomeSigninRequestNormal

        // このStateを初期状態へ戻す場合のアクション
        case restoreInitialState
    }
}
