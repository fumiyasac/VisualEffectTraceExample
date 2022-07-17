//
//  SigninAPIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/11.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: サインイン成功時用のAPIレスポンス定義
struct SigninSuccessResponse: Decodable, Equatable {

    let result: String
    let token: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
        case token
    }

    // MARK: - Initializer

    init(result: String, token: String) {
        self.result = result
        self.token = token
    }

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(String.self, forKey: .result)
        self.token = try container.decode(String.self, forKey: .token)
    }

    // MARK: - Equatable

    // MEMO: Equatableプロトコルに適合させるための処理

    static func == (lhs: SigninSuccessResponse, rhs: SigninSuccessResponse) -> Bool {
        return lhs.result == rhs.result && lhs.token == rhs.token
    }
}
