//
//  RequestAnnoucementDataRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/14.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol AnnoucementRepository {

    // お知らせ一覧表示用のAPIリクエストを実行する
    func requestAnnouncementDataList() -> Single<AnnouncementListResponse>
}

final class RequestAnnoucementDataRepository: AnnoucementRepository {

    // MARK: - Properties

    private let apiRequestManager: APIRequestProtocol

    // MARK: - Initializer

    init(apiRequestManager: APIRequestProtocol) {
        self.apiRequestManager = apiRequestManager
    }

    // MARK: - AnnoucementRepository

    func requestAnnouncementDataList() -> Single<AnnouncementListResponse> {
        return apiRequestManager.getAnnoucements()
    }
}
