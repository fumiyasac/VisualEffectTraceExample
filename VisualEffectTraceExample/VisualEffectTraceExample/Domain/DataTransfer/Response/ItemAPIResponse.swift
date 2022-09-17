//
//  ItemAPIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: アイテム一覧表示用のAPIレスポンス定義
struct ItemAPIResponse: Decodable, Equatable {

    let result: Array<ItemEntity>
    let currentPage: Int
    let hasNextPage: Bool

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
        case currentPage
        case hasNextPage
    }

    // MARK: - Initializer

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(Array<ItemEntity>.self, forKey: .result)
        self.currentPage = try container.decode(Int.self, forKey: .currentPage)
        self.hasNextPage = try container.decode(Bool.self, forKey: .hasNextPage)
    }

    // MARK: - Equatable

    // MEMO: Equatableプロトコルに適合させるための処理

    static func == (lhs: ItemAPIResponse, rhs: ItemAPIResponse) -> Bool {
        return lhs.result == rhs.result
    }
}
