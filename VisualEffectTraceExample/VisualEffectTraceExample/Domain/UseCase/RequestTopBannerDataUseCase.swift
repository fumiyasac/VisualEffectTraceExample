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

//sourcery: AutoMockable
protocol TopBannerUseCase {

    // トップバナー取得処理を実行する
    func execute() -> Single<TopBannerAPIResponse>
}

final class RequestTopBannerDataUseCase: TopBannerUseCase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "TopBannerRepository")) private var topBannerRepository: TopBannerRepository

    // MARK: - TopBannerUseCase

    func execute() -> Single<TopBannerAPIResponse> {
        return topBannerRepository.requestTopBannerDataList()
    }
}
