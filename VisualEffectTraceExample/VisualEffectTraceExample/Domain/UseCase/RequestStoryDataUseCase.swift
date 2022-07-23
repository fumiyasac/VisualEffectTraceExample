//
//  RequestStoryDataUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

//sourcery: AutoMockable
protocol StoryUseCase {

    // ストーリー一覧取得処理を実行する
    func execute() -> Single<StoryAPIResponse>
}

final class RequestStoryDataUseCase: StoryUseCase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "StoryRepository")) private var storyRepository: StoryRepository

    // MARK: - TopBannerUseCase

    func execute() -> Single<StoryAPIResponse> {
        return storyRepository.requestStoryDataList()
    }
}
