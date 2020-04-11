//
//  SigninScreenState.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/04.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

// サインイン画面に関するstateの定義
struct SigninScreenState: ReSwift.StateType {

    // 入力されたメールアドレス（初期値: ""）
    var mailAddress: String = ""

    // 入力されたパスワード（初期値: ""）
    var rawPassword: String = ""

    // サインイン処理が実行中かを判定するフラグ（初期値: false）
    var isProcessionSigninRequest: Bool = false

    // サインイン処理が成功かを判定するフラグ（初期値: false）
    var isSigninRequestSuccess: Bool = false

    // サインイン処理が失敗かを判定するフラグ（初期値: false）
    var isSigninRequestError: Bool = false
}
