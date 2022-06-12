//
//  AnnouncementListAPIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/23.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: お知らせ一覧表示用のAPIレスポンス定義
struct AnnouncementListAPIResponse: Decodable, Equatable {

    let result: Array<AnnouncementEntity>

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    init(result: Array<AnnouncementEntity>) {
        self.result = result
    }

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(Array<AnnouncementEntity>.self, forKey: .result)
    }

    // MARK: - Equatable

    // MEMO: Equatableプロトコルに適合させるための処理

    static func == (lhs: AnnouncementListAPIResponse, rhs: AnnouncementListAPIResponse) -> Bool {
        return lhs.result == rhs.result
    }
}
