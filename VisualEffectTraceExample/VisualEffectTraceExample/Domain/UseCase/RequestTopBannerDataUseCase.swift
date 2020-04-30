//
//  RequestTopBannerDataUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/30.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol TopBannerUsecase {

    // トップバナー取得処理を実行する
    func execute() -> Single<TopBannerAPIResponse>
}

final class RequestTopBannerDataUseCase: TopBannerUsecase {

    private let topBannerRepository: TopBannerRepository

    // MARK: - Initializer

    init(topBannerRepository: TopBannerRepository) {
        self.topBannerRepository = topBannerRepository
    }

    // MARK: - TopBannerUsecase

    func execute() -> Single<TopBannerAPIResponse> {
        return topBannerRepository.requestTopBannerDataList()
    }
}
