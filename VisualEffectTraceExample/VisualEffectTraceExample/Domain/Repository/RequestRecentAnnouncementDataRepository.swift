//
//  RequestRecentAnnouncementDataRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol RecentAnnouncementRepository {

    // 最新のお知らせを1件取得するAPIリクエストを実行する
    func requestRecentAnnouncementData() -> Single<AnnouncementDetailAPIResponse>
}

final class RequestRecentAnnouncementRepository: RecentAnnouncementRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - RecentAnnouncementRepository

    func requestRecentAnnouncementData() -> Single<AnnouncementDetailAPIResponse> {
        return apiRequestManager.getRecentAnnouncement()
    }
}
