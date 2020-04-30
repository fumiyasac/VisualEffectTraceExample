//
//  RequestTopBannerDataRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/30.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol TopBannerRepository {

    // トップバナー表示用のAPIリクエストを実行する
    func requestTopBannerDataList() -> Single<TopBannerAPIResponse>
}

final class RequestTopBannerDataRepository: TopBannerRepository {

    // MARK: - Properties

    private let apiRequestManager: APIRequestProtocol

    // MARK: - Initializer

    init(apiRequestManager: APIRequestProtocol) {
        self.apiRequestManager = apiRequestManager
    }

    // MARK: - TopBannerRepository

    func requestTopBannerDataList() -> Single<TopBannerAPIResponse> {
        return apiRequestManager.getTopBanners()
    }
}
