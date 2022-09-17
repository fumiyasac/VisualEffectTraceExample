//
//  RequestItemRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

//sourcery: AutoMockable
protocol ItemRepository {

    // 特集コンテンツ一覧用のAPIリクエストを実行する
    func requestItemDataList(page: Int) -> Single<ItemAPIResponse>
}

final class RequestItemRepository: ItemRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - ItemRepository

    func requestItemDataList(page: Int) -> Single<ItemAPIResponse> {
        apiRequestManager.getItemsBy(page: page)
    }
}
