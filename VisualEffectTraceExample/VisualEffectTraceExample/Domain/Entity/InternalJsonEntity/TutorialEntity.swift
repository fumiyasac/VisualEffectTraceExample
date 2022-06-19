//
//  TutorialEntity.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/22.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct TutorialEntity: Hashable, Decodable {

    let id: Int
    let title: String
    let thumbnail: String
    let catchCopy: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case title
        case thumbnail
        case catchCopy
    }
    
    // MARK: - Initializer

    init(
        id: Int,
        title: String,
        thumbnailUrl: String,
        catchCopy: String
    ) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnailUrl
        self.catchCopy = catchCopy
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.catchCopy = try container.decode(String.self, forKey: .catchCopy)
    }

    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TutorialEntity, rhs: TutorialEntity) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.thumbnail == rhs.thumbnail
            && lhs.catchCopy == rhs.catchCopy
    }
}
