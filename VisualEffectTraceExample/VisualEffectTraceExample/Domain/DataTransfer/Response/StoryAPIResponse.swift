//
//  StoryAPIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: Story表示用のAPIレスポンス定義
struct StoryAPIResponse: Decodable, Equatable {

    let result: Array<StoryEntity>

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    init(result: Array<StoryEntity>) {
        self.result = result
    }

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(Array<StoryEntity>.self, forKey: .result)
    }

    // MARK: - Equatable

    // MEMO: Equatableプロトコルに適合させるための処理

    static func == (lhs: StoryAPIResponse, rhs: StoryAPIResponse) -> Bool {
        return lhs.result == rhs.result
    }
}
