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
    func execute() -> Single<AnnouncementListResponse>
}

final class RequestAnnouncementDataUseCase: AnnouncementUsecase {

    private let annoucementRepository: AnnoucementRepository

    // MARK: - Initializer

    init(annoucementRepository: AnnoucementRepository) {
        self.annoucementRepository = annoucementRepository
    }

    // MARK: - AnnouncementUsecase

    func execute() -> Single<AnnouncementListResponse> {
        return annoucementRepository.requestAnnouncementDataList()
    }
}
