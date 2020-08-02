//
//  RequestItemDataUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol ItemUseCase {

    // アイテム一覧取得処理を実行する
    func execute(page: Int) -> Single<ItemAPIResponse>
}

final class RequestItemDataUseCase: ItemUseCase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "ItemRepository")) private var itemRepository: ItemRepository

    // MARK: - EventIntroductionUseCase

    func execute(page: Int) -> Single<ItemAPIResponse> {
        itemRepository.requestItemDataList(page: page)
    }
}
