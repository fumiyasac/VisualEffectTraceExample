//
//  SignupScreenAction.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

extension SignupScreenState {

    // サインイン画面に関するstateを変更させるアクションをEnumで定義する
    enum SignupScreenAction: ReSwift.Action {

        // ユーザーネーム入力欄へ入力があった場合のアクション
        case changeUserNameInput(targetText: String)

        // メールアドレス入力欄へ入力があった場合のアクション
        case changeMailAddressInput(targetText: String)

        // パスワード入力欄へ入力があった場合のアクション
        case changeRawPasswordInput(targetText: String)

        // サインアップ処理中の場合のアクション
        case isProcessingSignupRequest

        // サインアップ処理が成功した場合のアクション
        case becomeSignupRequestSuccess

        // サインアップ処理が失敗した場合のアクション
        case becomeSignupRequestError

        // サインアップ処理中状態を元に戻す場合のアクション
        case becomeSignupRequestNormal

        // このStateを初期状態へ戻す場合のアクション
        case restoreInitialState
    }
}
