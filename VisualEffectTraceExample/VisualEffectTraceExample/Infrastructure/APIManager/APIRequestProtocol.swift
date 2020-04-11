//
//  APIRequestProtocol.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/15.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

// ※ Mockに置き換えられるような形にしておくのがポイント

protocol APIRequestProtocol {

    // MEMO: 認証済みユーザーのAPIリクエスト
    func requestSiginin(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse>

    // MEMO: 公開部分のAPIリクエスト
    func getAnnoucements() -> Single<AnnouncementListResponse>
    func getAnnoucementDetailBy(id: Int) -> Single<AnnouncementDetailResponse>
}
