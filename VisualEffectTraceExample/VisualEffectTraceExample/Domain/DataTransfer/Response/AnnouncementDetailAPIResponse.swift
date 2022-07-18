//
//  AnnouncementDetailAPIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/20.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: お知らせ詳細表示用のAPIレスポンス定義
// ※ ここではアイテム表示画面のお知らせ表示セクションとお知らせ詳細画面で利用する

struct AnnouncementDetailAPIResponse: Decodable, Equatable {

    let result: AnnouncementEntity

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    init(result: AnnouncementEntity) {
        self.result = result
    }

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(AnnouncementEntity.self, forKey: .result)
    }

    // MARK: - Equatable

    // MEMO: Equatableプロトコルに適合させるための処理

    static func == (lhs: AnnouncementDetailAPIResponse, rhs: AnnouncementDetailAPIResponse) -> Bool {
        return lhs.result == rhs.result
    }
}
