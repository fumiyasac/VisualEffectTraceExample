//
//  RequestEventIntroductionDataRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/30.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol EventIntroductionRepository {

    // イベント概要一覧用のAPIリクエストを実行する
    func requestEventIntroductionDataList(page: Int) -> Single<EventIntroductionAPIResponse>
}

final class RequestEventIntroductionDataRepository: EventIntroductionRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - EventIntroductionRepository

    func requestEventIntroductionDataList(page: Int) -> Single<EventIntroductionAPIResponse> {
        return apiRequestManager.getEventIntroductionsBy(page: page)
    }
}
