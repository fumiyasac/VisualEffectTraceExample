//
//  RequestStoryDataRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol StoryRepository {

    // ストーリー一覧表示用のAPIリクエストを実行する
    func requestStoryDataList() -> Single<StoryAPIResponse>
}

final class RequestStoryRepository: StoryRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - SigninRepository

    func requestStoryDataList() -> Single<StoryAPIResponse> {
        return apiRequestManager.getStories()
    }
}
