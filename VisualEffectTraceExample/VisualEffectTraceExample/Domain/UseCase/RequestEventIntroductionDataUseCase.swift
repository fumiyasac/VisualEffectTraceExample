//
//  RequestEventIntroductionDataUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/30.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol EventIntroductionUseCase {

    // イベント概要一覧取得処理を実行する
    func execute(page: Int) -> Single<EventIntroductionAPIResponse>
}

final class RequestEventIntroductionDataUseCase: EventIntroductionUseCase {

    private let eventIntroductionRepository: EventIntroductionRepository

    // MARK: - Initializer

    init(eventIntroductionRepository: EventIntroductionRepository) {
        self.eventIntroductionRepository = eventIntroductionRepository
    }

    // MARK: - EventIntroductionUseCase

    func execute(page: Int) -> Single<EventIntroductionAPIResponse> {
        return eventIntroductionRepository.requestEventIntroductionDataList(page: page)
    }
}
