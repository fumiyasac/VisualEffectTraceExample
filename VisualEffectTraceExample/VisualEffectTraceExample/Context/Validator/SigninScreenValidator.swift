//
//  SigninScreenValidator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/06.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// サインイン画面でのバリデーションとして適用するものを定義する

// MARK: - Struct

struct SigninScreenValidator {}

extension SigninScreenValidator {

    // メールアドレス入力時におけるバリデーション
    struct mailAddressValidator: CompositionalValidator {
        var validators: [Validator] = [
            ApplicationValidator.EmptyValidator(),
            ApplicationValidator.MatchMailAddressFormatValidator()
        ]
    }

    // パスワード入力時におけるバリデーション
    struct rawPasswordValidator: CompositionalValidator {
        var validators: [Validator] = [
            ApplicationValidator.EmptyValidator(),
            ApplicationValidator.NumericAndUpperAndlowerCaseValidator(),
            ApplicationValidator.BetweenLengthValidator(min: 6, max: 50)
        ]
    }
}
