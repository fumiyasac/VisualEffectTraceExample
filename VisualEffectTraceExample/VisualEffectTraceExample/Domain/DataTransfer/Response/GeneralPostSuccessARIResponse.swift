//
//  GeneralPostSuccessARIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/13.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: POST結果のみのAPIレスポンス定義
struct GeneralPostSuccessARIResponse: Decodable {

    let result: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(String.self, forKey: .result)
    }
}
