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

//sourcery: AutoMockable
protocol APIRequestProtocol {

    // MEMO: 認証済みユーザーのAPIリクエスト

    // Item.storyboardで利用するエンドポイント
    func getTopBanners() -> Single<TopBannerAPIResponse>
    func getEventIntroductionsBy(page: Int) -> Single<EventIntroductionAPIResponse>
    func getRecentAnnouncement() -> Single<AnnouncementDetailAPIResponse>
    func getItemsBy(page: Int) -> Single<ItemAPIResponse>

    // Featured.storyboardで利用するエンドポイント
    func getFeaturedArticles() -> Single<FeaturedArticleAPIResponse>

    // Story.storyboardで利用するエンドポイント
    func getStories() -> Single<StoryAPIResponse>

    // MEMO: 公開部分のAPIリクエスト

    // Announcement.storyboardで利用するエンドポイント
    func getAnnouncements() -> Single<AnnouncementListAPIResponse>

    // Signin.storyboardで利用するエンドポイント
    func requestSiginin(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse>

    // Signup.storyboardで利用するエンドポイント
    func requestSiginup(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse>
}
