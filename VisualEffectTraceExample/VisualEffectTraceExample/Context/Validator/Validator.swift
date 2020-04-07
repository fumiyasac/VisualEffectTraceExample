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
            return ""
        case .shouldMinLength(let min):
            return "エラー: \(min)文字以上で入力してください。"
        case .shouldMaxLength(let max):
            return "エラー: \(max)文字以下で入力してください。"
        case .shouldBetweenLength(let min, let max):
            return "エラー: \(min)〜\(max)文字の範囲で入力してください。"
        case .shouldKatakanaFormat:
            return "エラー: 全角カタカナのみで入力してください。"
        case .shouldUpperAndlowerCaseFormat:
            return "エラー: 半角英字(記号なし)のみで入力してください。"
        case .shouldNumericAndUpperAndlowerCaseFormat:
            return "エラー: 半角英数字(記号なし)のみで入力してください。"
        case .shouldMatchMailAddressFormat:
            return "エラー: 正しいメールアドレス形式で入力してください。"
        }
    }
}

// 各種Validation結果に関するEnum定義
enum ValidationResult {

    case valid
    case invalid(errors: ValidationError)
}

// MARK: - Struct

struct ApplicationValidator {}

// MARK: - ApplicationValidator

// MEMO: 各種ValidationErrorで定義したValidationロジックを定義する
extension ApplicationValidator {

    // 空文字のチェック
    struct EmptyValidator: Validator {

        func validate(_ value: String) -> ValidationResult {

            let condition = (!value.isEmpty)
            return condition ? .valid : .invalid(errors: .empty)
        }
    }

    // 最小文字数のチェック
    struct MinLengthValidator: Validator {

        let min: Int

        func validate(_ value: String) -> ValidationResult {

            let condition = (value.count <= min)
            return condition ? .valid : .invalid(errors: .shouldMinLength(min: min))
        }
    }

    // 最大文字数のチェック
    struct MaxLengthValidator: Validator {

        let max: Int

        func validate(_ value: String) -> ValidationResult {

            let condition = (value.count >= max)
            return condition ? .valid : .invalid(errors: .shouldMaxLength(max: max))
        }
    }

    // 文字数範囲のチェック
    struct BetweenLengthValidator: Validator {

        let min: Int
        let max: Int

        func validate(_ value: String) -> ValidationResult {

            let condition = (min...max ~= value.count)
            return condition ? .valid : .invalid(errors: .shouldBetweenLength(min: min, max: max))
        }
    }

    // 全角カタカナのチェック
    struct KatakanaValidator: Validator {

        func validate(_ value: String) -> ValidationResult {

            let regexString = "^[ァ-ヾ]+$"
            let condition = shouldMatchRegexPattern(string: value, regexString: regexString)
            return condition ? .valid : .invalid(errors: .shouldKatakanaFormat)
        }
    }

    // 半角英字(記号なし)のみのチェック
    struct UpperAndlowerCaseValidator: Validator {

        func validate(_ value: String) -> ValidationResult {

            let regexString = "[a-zA-Z]"
            let condition = shouldMatchRegexPattern(string: value, regexString: regexString)
            return condition ? .valid : .invalid(errors: .shouldUpperAndlowerCaseFormat)
        }
    }

    // 半角英数字(記号なし)のみのチェック
    struct NumericAndUpperAndlowerCaseValidator: Validator {

        func validate(_ value: String) -> ValidationResult {

            let regexString = "[a-zA-Z0-9]"
            let condition = shouldMatchRegexPattern(string: value, regexString: regexString)
            return condition ? .valid : .invalid(errors: .shouldNumericAndUpperAndlowerCaseFormat)
        }
    }

    // 正しいメールアドレス形式のチェック
    struct MatchMailAddressFormatValidator: Validator {

        func validate(_ value: String) -> ValidationResult {

            let regexString = "^([A-Z0-9a-z._+-])+@([A-Za-z0-9.-])+\\.([A-Za-z]{2,4})+$"
            let condition = shouldMatchRegexPattern(string: value, regexString: regexString)
            return condition ? .valid : .invalid(errors: .shouldMatchMailAddressFormat)
        }
    }
}

// MARK: - Fileprivate Function

// MEMO: 正規表現のパターンマッチを実行するための処理

fileprivate func shouldMatchRegexPattern(string: String, regexString: String) -> Bool {
    guard let regex = try? NSRegularExpression(pattern: regexString, options: NSRegularExpression.Options()) else {
        return false
    }
    let numberOfMatchResult = regex.numberOfMatches(
        in: string,
        options: NSRegularExpression.MatchingOptions(),
        range: NSRange(location: 0, length: string.count)
    )
    return numberOfMatchResult > 0
}

