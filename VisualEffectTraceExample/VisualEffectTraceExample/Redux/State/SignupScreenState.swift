//
//  SignupScreenState.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

// サインアップ画面に関するstateの定義
struct SignupScreenState: ReSwift.StateType {

    // 入力されたユーザーネーム（初期値: ""）
    var userName: String = ""

    // 入力されたメールアドレス（初期値: ""）
    var mailAddress: String = ""

    // 入力されたパスワード（初期値: ""）
    var rawPassword: String = ""

    // サインアップ処理が実行中かを判定するフラグ（初期値: false）
    var isProcessionSignupRequest: Bool = false

    // サインアップ処理が成功かを判定するフラグ（初期値: false）
    var isSignupRequestSuccess: Bool = false

    // サインアップ処理が失敗かを判定するフラグ（初期値: false）
    var isSignupRequestError: Bool = false
}
