//
//  RequestFeaturedArticleRepositorySpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/07/18.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class RequestFeaturedArticleRepositorySpec: QuickSpec {

    // MARK: - Override

    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let apiRequestManager = APIRequestProtocolMock()
        let target = RequestFeaturedArticleRepository()

        describe("RequestFeaturedArticleRepository") {

            // MARK: - requestFeaturedArticleDataListを実行した際のテスト

            describe("#requestFeaturedArticleDataList") {

                // MEMO: API通信処理成功時の想定
                context("APIから正常にデータが返却される場合") {
                    let featuredArticleAPIResponse = getFeaturedArticleAPIResponse()

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: apiRequestManager,
                            protocolName: APIRequestProtocol.self
                        )
                        apiRequestManager.given(
                            .getFeaturedArticles(
                                willReturn: Single.just(featuredArticleAPIResponse)
                            )
                        )
                    }
                    afterEach {
                        testingDependency.removeIndividualMock(
                            protocolName: APIRequestProtocol.self
                        )
                    }
                    it("StubのJSON値を変換したものをそのまま返却すること") {
                        expect(
                            try! target.requestFeaturedArticleDataList().toBlocking().first()
                        ).to(
                            equal(featuredArticleAPIResponse)
                        )
                    }
                }
            }
        }
    }

    private func getFeaturedArticleAPIResponse() -> FeaturedArticleAPIResponse {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle(for: type(of: self)).path(forResource: "featured_article_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let featuredArticleAPIResponse = try? JSONDecoder().decode(FeaturedArticleAPIResponse.self, from: data) else {
            fatalError()
        }
        return featuredArticleAPIResponse
    }
}
