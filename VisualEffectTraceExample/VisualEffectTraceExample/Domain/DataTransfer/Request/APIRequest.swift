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

        // MEMO: 認証済みユーザーのみ利用可能なエンドポイント

        // Item.storyboardで利用するエンドポイント
        case topBanner = "top_banner"
        case eventIntroduction = "event_introduction"

        // MEMO: 認証前の画面でも利用可能なエンドポイント

        // Announcement.storyboardで利用するエンドポイント
        case announcement = "announcement"

        // Signin.storyboardで利用するエンドポイント
        case signin = "signin"

        // Signup.storyboardで利用するエンドポイント
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

    // 最新のお知らせ詳細表示用のAPIリクエスト処理の実行
    func getRecentAnnouncement() -> Single<AnnouncementDetailResponse> {
        let recentAnnoucementEndPoint = EndPoint.announcement.getBaseUrl() + "/recent"
        return executeAPIRequest(
            endpointUrl: recentAnnoucementEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: AnnouncementDetailResponse.self
        )
    }

    // お知らせ詳細表示用のAPIリクエスト処理の実行
    func getAnnouncementDetailBy(id: Int) -> Single<AnnouncementDetailResponse> {
        let annoucementDetailEndPoint = EndPoint.announcement.getBaseUrl() + "/" + String(id)
        return executeAPIRequest(
            endpointUrl: annoucementDetailEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: AnnouncementDetailResponse.self
        )
    }

    // お知らせ一覧表示用のAPIリクエスト処理の実行
    func getAnnouncements() -> Single<AnnouncementListResponse> {
        let annoucementListsEndPoint = EndPoint.announcement.getBaseUrl()
        return executeAPIRequest(
            endpointUrl: annoucementListsEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: AnnouncementListResponse.self
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
