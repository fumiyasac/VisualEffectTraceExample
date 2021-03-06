//
//  FeaturedArticleEntity.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct FeaturedArticleEntity: Hashable, Decodable {

    let id: Int
    let title: String
    let catchCopy: String
    let statement: String
    let thumbnailUrl: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case title
        case catchCopy
        case statement
        case thumbnailUrl
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.catchCopy = try container.decode(String.self, forKey: .catchCopy)
        self.statement = try container.decode(String.self, forKey: .statement)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
    }

    // MARK: - Hashable
    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: FeaturedArticleEntity, rhs: FeaturedArticleEntity) -> Bool {
        return lhs.id == rhs.id
    }
}
