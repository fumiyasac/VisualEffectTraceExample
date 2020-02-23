//
//  AnnouncementListResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/23.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct AnnouncementListResponse: Decodable {

    let result: Array<AnnouncementEntity>

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.result = try container.decode(Array<AnnouncementEntity>.self, forKey: .result)
    }
}
