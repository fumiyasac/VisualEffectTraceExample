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

//sourcery: AutoMockable
protocol TopBannerRepository {

    // トップバナー表示用のAPIリクエストを実行する
    func requestTopBannerDataList() -> Single<TopBannerAPIResponse>
}

final class RequestTopBannerDataRepository: TopBannerRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - TopBannerRepository

    func requestTopBannerDataList() -> Single<TopBannerAPIResponse> {
        return apiRequestManager.getTopBanners()
    }
}
