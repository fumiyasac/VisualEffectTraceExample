//
//  RequestAnnouncementDataUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/14.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol AnnouncementUsecase {

    // お知らせ一覧取得処理を実行する
    func execute() -> Single<AnnouncementListAPIResponse>
}

final class RequestAnnouncementDataUseCase: AnnouncementUsecase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "AnnouncementRepository")) private var announcementRepository: AnnouncementRepository

    // MARK: - AnnouncementUsecase

    func execute() -> Single<AnnouncementListAPIResponse> {
        return announcementRepository.requestAnnouncementDataList()
    }
}
