//
//  Validator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/06.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// 画面表示側のバリデーションメッセージを定義するためのProtocol定義
// 参考1: https://iganin.hatenablog.com/entry/2019/09/23/171221
// 参考2: https://qiita.com/to4iki/items/1dfde228654fff93df2c

// MARK: - Protocol

// 各種Validationエラー表示文言用のプロトコル
// MEMO: .localizedDescriptionでエラーメッセージを表示可能
protocol ValidationErrorProtocol: LocalizedError {}

// 文字列のValidation処理に関するプロトコル
protocol Validator {
    func validate(_ value: String) -> ValidationResult
}

// MARK: - Enum

// 各種Validationエラー表示用文言の内容に関する定義
enum ValidationError: ValidationErrorProtocol {

    case empty
    case shouldMinLength(min: Int)
    case shouldMaxLength(max: Int)
    case shouldBetweenLength(min: Int, max: Int)
    case shouldKatakanaFormat
    case shouldUpperAndlowerCaseFormat
    case shouldNumericAndUpperAndlowerCaseFormat
    case shouldMatchMailAddressFormat

    // MARK: - Property

    var errorDescription: String? {
        switch self {
        case .empty:
            return "文字を入力してください"
        case .shouldMinLength(let min):
            return "\(min)文字以上で入力してください。"
        case .shouldMaxLength(let max):
            return "\(max)文字以下で入力してください。"
        case .shouldBetweenLength(let min, let max):
            return "\(min)〜\(max)文字の範囲で入力してください。"
        case .shouldKatakanaFormat:
            return "全角カタカナのみで入力してください。"
        case .shouldUpperAndlowerCaseFormat:
            return "半角英字(ハイフンなし)のみで入力してください。"
        case .shouldNumericAndUpperAndlowerCaseFormat:
            return "半角英数字(ハイフンなし)のみで入力してください。"
        case .shouldMatchMailAddressFormat:
            return "正しいメールアドレス形式で入力してください。"
        }
    }
}

// 各種Validation結果に関するEnum定義
enum ValidationResult {

    case valid
    case invalid(errors: ValidationError)
}

// MARK: - Struct

// 各種ValidationErrorで定義したValidationロジックを定義する
