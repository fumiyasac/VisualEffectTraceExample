//
//  EventIntroductionEntity.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/30.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct EventIntroductionEntity: Hashable, Decodable {

    let id: Int
    let eventIntroductionId: Int
    let thumbnailUrl: String
    let title: String
    let caption: String
    let statement: String
    let announcementAt: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case eventIntroductionId
        case thumbnailUrl
        case title
        case caption
        case statement
        case announcementAt
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.eventIntroductionId = try container.decode(Int.self, forKey: .eventIntroductionId)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        self.title = try container.decode(String.self, forKey: .title)
        self.caption = try container.decode(String.self, forKey: .caption)
        self.statement = try container.decode(String.self, forKey: .statement)
        self.announcementAt = try container.decode(String.self, forKey: .announcementAt)
    }

    // MARK: - Hashable
    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: EventIntroductionEntity, rhs: EventIntroductionEntity) -> Bool {
        return lhs.id == rhs.id
    }
}
