//
//  TopBannerAPIResponse.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/30.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: トップバナー表示用のAPIレスポンス定義
struct TopBannerAPIResponse: Decodable, Equatable {

    let result: Array<TopBannerEntity>

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case result
    }

    // MARK: - Initializer

    init(result: Array<TopBannerEntity>) {
        self.result = result
    }

    // JSONの配列内の要素を取得する → JSONの配列内の要素にある値をDecodeして初期化する
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.result = try container.decode(Array<TopBannerEntity>.self, forKey: .result)
    }

    // MARK: - Equatable

    // MEMO: Equatableプロトコルに適合させるための処理

    static func == (lhs: TopBannerAPIResponse, rhs: TopBannerAPIResponse) -> Bool {
        return lhs.result == rhs.result
    }
}
