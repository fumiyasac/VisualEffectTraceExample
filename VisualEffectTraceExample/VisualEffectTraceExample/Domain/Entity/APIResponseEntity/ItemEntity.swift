//
//  ItemEntity.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct ItemEntity: Hashable, Decodable {

    let id: Int
    let title: String
    let statement: String
    let thumbnailUrl: String
    let announcementAt: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case title
        case statement
        case thumbnailUrl
        case announcementAt
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.statement = try container.decode(String.self, forKey: .statement)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        self.announcementAt = try container.decode(String.self, forKey: .announcementAt)
    }

    // MARK: - Hashable
    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ItemEntity, rhs: ItemEntity) -> Bool {
        return lhs.id == rhs.id
    }
}
