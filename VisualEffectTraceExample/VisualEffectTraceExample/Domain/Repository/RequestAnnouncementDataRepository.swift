//
//  RequestAnnouncementDataRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/14.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol AnnouncementRepository {

    // お知らせ一覧表示用のAPIリクエストを実行する
    func requestAnnouncementDataList() -> Single<AnnouncementListResponse>
}

final class RequestAnnouncementDataRepository: AnnouncementRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - AnnouncementRepository

    func requestAnnouncementDataList() -> Single<AnnouncementListResponse> {
        return apiRequestManager.getAnnouncements()
    }
}
