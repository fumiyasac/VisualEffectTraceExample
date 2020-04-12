//
//  SignupScreenValidator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// サインイン画面でのバリデーションとして適用するものを定義する

// MARK: - Struct

struct SignupScreenValidator {}

extension SignupScreenValidator {

    // ユーザーネームにおけるバリデーション
    struct UserNameValidator: CompositionalValidator {
        var validators: [Validator] = [
            ApplicationValidator.EmptyValidator(),
            ApplicationValidator.NumericAndUpperAndlowerCaseValidator(),
            ApplicationValidator.BetweenLengthValidator(min: 6, max: 50)
        ]
    }

    // メールアドレス入力時におけるバリデーション
    struct MailAddressValidator: CompositionalValidator {
        var validators: [Validator] = [
            ApplicationValidator.EmptyValidator(),
            ApplicationValidator.MatchMailAddressFormatValidator()
        ]
    }

    // パスワード入力時におけるバリデーション
    struct RawPasswordValidator: CompositionalValidator {
        var validators: [Validator] = [
            ApplicationValidator.EmptyValidator(),
            ApplicationValidator.NumericAndUpperAndlowerCaseValidator(),
            ApplicationValidator.BetweenLengthValidator(min: 6, max: 50)
        ]
    }
}
