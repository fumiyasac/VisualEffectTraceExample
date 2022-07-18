//
//  RequestRecentAnnouncementDataUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

//sourcery: AutoMockable
protocol RecentAnnouncementUseCase {

    // 最新お知らせ取得処理を実行する
    func execute() -> Single<AnnouncementDetailAPIResponse>
}

final class RequestRecentAnnouncementDataUseCase: RecentAnnouncementUseCase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "RecentAnnouncementRepository")) private var recentAnnouncementRepository: RecentAnnouncementRepository

    // MARK: - RecentAnnoucementUseCase

    func execute() -> Single<AnnouncementDetailAPIResponse> {
        return recentAnnouncementRepository.requestRecentAnnouncementData()
    }
}
