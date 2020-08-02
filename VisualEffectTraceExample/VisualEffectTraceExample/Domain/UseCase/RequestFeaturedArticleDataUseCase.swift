//
//  RequestFeaturedArticleDataUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol FeaturedArticleUseCase {

    // 特集コンテンツ一覧取得処理を実行する
    func execute() -> Single<FeaturedArticleAPIResponse>
}

final class RequestFeaturedArticleDataUseCase: FeaturedArticleUseCase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "FeaturedArticleRepository")) private var featuredArticleRepository: FeaturedArticleRepository

    // MARK: - EventIntroductionUseCase

    func execute() -> Single<FeaturedArticleAPIResponse> {
        return featuredArticleRepository.requestFeaturedArticleDataList()
    }
}
