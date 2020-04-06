//
//  FormInputTextFieldStyle.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/31.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: サインイン画面・新規会員登録画面をはじめとしたユーザーの入力を伴うViewを振り分けるための識別用
enum FormInputTextFieldStyle {

    // 普通の文字入力用テキストフィールド（※特に何もない場合のデフォルト指定）
    case defaultTextInput

    // メールアドレス入力用テキストフィールド
    case mailAddressTextInput

    // パスワード入力用テキストフィールド
    case securePasswordTextInput

    // 電話番号入力用テキストフィールド
    case telephoneNumberTextInput
}
