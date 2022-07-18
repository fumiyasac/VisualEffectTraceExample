//
//  FeaturedArticleAPIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: FeaturedArticle表示用のAPIレスポンス定義
struct FeaturedArticleAPIResponse: Decodable, Equatable {

    let result: Array<FeaturedArticleEntity>

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    init(result: Array<FeaturedArticleEntity>) {
        self.result = result
    }

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(Array<FeaturedArticleEntity>.self, forKey: .result)
    }

    // MARK: - Equatable

    // MEMO: Equatableプロトコルに適合させるための処理

    static func == (lhs: FeaturedArticleAPIResponse, rhs: FeaturedArticleAPIResponse) -> Bool {
        return lhs.result == rhs.result
    }
}
