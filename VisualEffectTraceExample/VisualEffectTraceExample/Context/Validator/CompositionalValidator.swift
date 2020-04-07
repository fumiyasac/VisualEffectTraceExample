//
//  CompositionalValidator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/06.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// 複数のバリデーションをまとめるためのプロトコル
// 参考: https://iganin.hatenablog.com/entry/2019/09/23/171221

// MARK: - Protocol

protocol CompositionalValidator: Validator {

    // 適用したいバリデーションを複数格納するための変数
    var validators: [Validator] { get }

    // 任意の文字列に対して適用するバリデーション処理を実行する
    func validate(_ value: String) -> ValidationResult
}

// MARK: - CompositionalValidator

extension CompositionalValidator {

    // MARK: - Function

    func validate(_ value: String) -> ValidationResult {

        // MEMO: 引数から取得した値に対して、変数名validatorsに追加したバリデーションロジックを順次実行していく
        let results: [ValidationResult] = migrateValidationResult(value)

        // MEMO: ValidationResult型の結果のうち最新のものを返すように加工する
        let errors = results.filter { result -> Bool in
            switch result {
            case .valid:
                return false
            case .invalid:
                return true
            }
        }
        return errors.first ?? .valid
    }

    // MARK: - Private Function

    // MEMO: 変数名validators
    private func migrateValidationResult(_ value: String) -> [ValidationResult] {
        return validators.map { $0.validate(value) }
    }
}
