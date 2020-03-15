//
//  AnnouncementEntity.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/22.
//  Copyright © 2020 酒井文也. All rights reserved.
//
import Foundation

struct AnnouncementEntity: Hashable, Decodable {

    let id: Int
    let title: String
    let statement: String

    // MARK: - Enum
    private enum Keys: String, CodingKey {
        case id
        case title
        case statement
    }

    // MARK: - Initializer
    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.statement = try container.decode(String.self, forKey: .statement)
    }

    // MARK: - Hashable
    // MEMO: Hashableプロトコルに適合させるための処理
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: AnnouncementEntity, rhs: AnnouncementEntity) -> Bool {
        return lhs.id == rhs.id
    }
}
