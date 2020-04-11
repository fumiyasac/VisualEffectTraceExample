//
//  APIRequest.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/15.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - APIRequestManagerProtocol

extension APIRequestManager: APIRequestProtocol {

    // MEMO: サンプルで利用するエンドポイント定義
    private enum EndPoint: String {

        case announcement = "announcement"
        case signin = "signin"

        func getBaseUrl() -> String {
            return [host, version, self.rawValue].joined(separator: "/")
        }
    }

    // MARK: - Function

    // お知らせ一覧表示用のAPIリクエスト処理の実行
    func getAnnoucements() -> Single<AnnouncementListResponse> {

        let annoucementListsEndPoint = EndPoint.announcement.getBaseUrl()
        return executeAPIRequest(
            endpointUrl: annoucementListsEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: AnnouncementListResponse.self
        )
    }

    // お知らせ詳細表示用のAPIリクエスト処理の実行
    func getAnnoucementDetailBy(id: Int) -> Single<AnnouncementDetailResponse> {

        let annoucementDetailEndPoint = EndPoint.announcement.getBaseUrl() + "/" + String(id)
        return executeAPIRequest(
            endpointUrl: annoucementDetailEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: AnnouncementDetailResponse.self
        )
    }

    // お知らせ詳細表示用のAPIリクエスト処理の実行
    func requestSiginin(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse> {
        let parameters: [String : Any] = [
            "mail_address" : mailAddress,
            "password" : rawPassword
        ]
        let signinEndPoint = EndPoint.signin.getBaseUrl()
        return executeAPIRequest(
            endpointUrl: signinEndPoint,
            withParameters: parameters,
            httpMethod: HTTPMethod.POST,
            responseFormat: SigninSuccessResponse.self
        )
    }
}
