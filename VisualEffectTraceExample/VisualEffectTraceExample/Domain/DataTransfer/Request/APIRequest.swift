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

        // Item.storyboardで利用するエンドポイント
        case topBanner = "top_banner"
        case eventIntroduction = "event_introduction"

        // 認証前の画面で利用するエンドポイント
        case announcement = "announcement"
        case signin = "signin"
        case signup = "signup"

        func getBaseUrl() -> String {
            return [host, version, self.rawValue].joined(separator: "/")
        }
    }

    // MARK: - Function

    // トップバナー表示用のAPIリクエスト処理の実行
    func getTopBanners() -> Single<TopBannerAPIResponse> {

        let topBannerEndPoint = EndPoint.topBanner.getBaseUrl()
        return executeAPIRequest(
            endpointUrl: topBannerEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: TopBannerAPIResponse.self
        )
    }

    // イベント概要一覧表示用のAPIリクエスト処理の実行
    func getEventIntroductionsBy(page: Int) -> Single<EventIntroductionAPIResponse> {

        let eventIntroductionEndPoint = EndPoint.eventIntroduction.getBaseUrl() + "?page=" + String(page)
        return executeAPIRequest(
            endpointUrl: eventIntroductionEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: EventIntroductionAPIResponse.self
        )
    }

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

    // サインイン処理用のAPIリクエスト処理の実行
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

    // サインアップ処理用のAPIリクエスト処理の実行
    func requestSiginup(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse> {
        let parameters: [String : Any] = [
            "user_name" : userName,
            "mail_address" : mailAddress,
            "password" : rawPassword
        ]
        let signupEndPoint = EndPoint.signup.getBaseUrl()
        return executeAPIRequest(
            endpointUrl: signupEndPoint,
            withParameters: parameters,
            httpMethod: HTTPMethod.POST,
            responseFormat: GeneralPostSuccessARIResponse.self
        )
    }
}
