//
//  AnnouncementAPIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/23.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: お知らせ一覧表示用のAPIレスポンス定義
struct AnnouncementListResponse: Decodable {

    let result: Array<AnnouncementEntity>

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(Array<AnnouncementEntity>.self, forKey: .result)
    }
}

// MEMO: お知らせ詳細表示用のAPIレスポンス定義
struct AnnouncementDetailResponse: Decodable {

    let result: AnnouncementEntity

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(AnnouncementEntity.self, forKey: .result)
    }
}
