//
//  APIRequest.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/15.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

/*
＜補足: RxSwiftを利用したAPIリクエストの実装例＞

(1) 一覧表示用のリクエストを取得する際の実装例
let api = APIRequestManager.shared
let _ = api.getAnnoucements()
    .subscribe(
        onSuccess: { data in
            print(data.result)
        },
        onError: { error in
            print(error)
        }
    )
    .disposed(by: disposeBag)

(2) 詳細表示用のリクエストを取得する際の実装例
let _ = api.getAnnoucementDetailBy(id: 1)
    .subscribe(
        onSuccess: { data in
            print(data.result)
        },
        onError: { error in
            print(error)
        }
    )
    .disposed(by: disposeBag)

*/

// MARK: - APIRequestManagerProtocol

extension APIRequestManager: APIRequestProtocol {

    // MEMO: サンプルで利用するエンドポイント定義
    private enum EndPoint: String {

        // MEMO: 認証済みユーザーのみ利用可能なエンドポイント

        // Item.storyboardで利用するエンドポイント
        case topBanner = "top_banner"
        case eventIntroduction = "event_introduction"
        case items = "items"

        // Story.storyboardで利用するエンドポイント
        case story = "story"

        // Featured.storyboardで利用するエンドポイント
        case featuredArticle = "featured_article"

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

    // アイテム一覧表示用のAPIリクエスト処理の実行
    func getItemsBy(page: Int) -> Single<ItemAPIResponse> {
        let itemsEndPoint = EndPoint.items.getBaseUrl() + "?page=" + String(page)
        return executeAPIRequest(
            endpointUrl: itemsEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: ItemAPIResponse.self
        )
    }

    // ストーリー一覧表示用のAPIリクエスト処理の実行
    func getStories() -> Single<StoryAPIResponse> {
        let storyListsEndPoint = EndPoint.story.getBaseUrl()
        return executeAPIRequest(
            endpointUrl: storyListsEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: StoryAPIResponse.self
        )
    }

    // 特集コンテンツ一覧一覧表示用のAPIリクエスト処理の実行
    func getFeaturedArticles() -> Single<FeaturedArticleAPIResponse> {
        let featuredArticleListsEndPoint = EndPoint.featuredArticle.getBaseUrl()
        return executeAPIRequest(
            endpointUrl: featuredArticleListsEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: FeaturedArticleAPIResponse.self
        )
    }

    // 最新のお知らせ詳細表示用のAPIリクエスト処理の実行
    func getRecentAnnouncement() -> Single<AnnouncementDetailAPIResponse> {
        let recentAnnoucementEndPoint = EndPoint.announcement.getBaseUrl() + "/recent"
        return executeAPIRequest(
            endpointUrl: recentAnnoucementEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: AnnouncementDetailAPIResponse.self
        )
    }

    // お知らせ一覧表示用のAPIリクエスト処理の実行
    func getAnnouncements() -> Single<AnnouncementListAPIResponse> {
        let annoucementListsEndPoint = EndPoint.announcement.getBaseUrl()
        return executeAPIRequest(
            endpointUrl: annoucementListsEndPoint,
            httpMethod: HTTPMethod.GET,
            responseFormat: AnnouncementListAPIResponse.self
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
