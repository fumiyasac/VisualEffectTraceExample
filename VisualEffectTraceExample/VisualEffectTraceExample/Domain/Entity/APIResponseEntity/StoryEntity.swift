//
//  StoryEntity.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct StoryEntity: Hashable, Decodable {

    let id: Int
    let title: String
    let catchCopy: String
    let mainStatement: String
    let subStatement: String
    let thumbnailUrl: String
    let author: String
    let announcementAt: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case title
        case catchCopy
        case mainStatement
        case subStatement
        case thumbnailUrl
        case author
        case announcementAt
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.catchCopy = try container.decode(String.self, forKey: .catchCopy)
        self.mainStatement = try container.decode(String.self, forKey: .mainStatement)
        self.subStatement = try container.decode(String.self, forKey: .subStatement)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        self.author = try container.decode(String.self, forKey: .author)
        self.announcementAt = try container.decode(String.self, forKey: .announcementAt)
    }

    // MARK: - Hashable
    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: StoryEntity, rhs: StoryEntity) -> Bool {
        return lhs.id == rhs.id
    }
}
