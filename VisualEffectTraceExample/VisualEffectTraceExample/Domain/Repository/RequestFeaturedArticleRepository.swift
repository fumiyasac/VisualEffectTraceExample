//
//  RequestFeaturedArticleRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol FeaturedArticleRepository {

    // 特集コンテンツ一覧用のAPIリクエストを実行する
    func requestFeaturedArticleDataList() -> Single<FeaturedArticleAPIResponse>
}

final class RequestFeaturedArticleRepository: FeaturedArticleRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - FeaturedArticleRepository

    func requestFeaturedArticleDataList() -> Single<FeaturedArticleAPIResponse> {
        return apiRequestManager.getFeaturedArticles()
    }
}
