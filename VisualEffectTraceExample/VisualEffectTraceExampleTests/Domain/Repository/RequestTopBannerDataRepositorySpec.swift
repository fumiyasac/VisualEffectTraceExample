//
//  RequestTopBannerDataRepositorySpec.swift
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

final class RequestTopBannerDataRepositorySpec: QuickSpec {

    // MARK: - Override

    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let apiRequestManager = APIRequestProtocolMock()
        let target = RequestTopBannerDataRepository()

        describe("RequestTopBannerDataRepository") {

            // MARK: - requestTopBannerDataListを実行した際のテスト

            describe("#requestTopBannerDataList") {

                // MEMO: API通信処理成功時の想定
                context("APIから正常にデータが返却される場合") {
                    let topBannerAPIResponse = getTopBannerAPIResponse()

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: apiRequestManager,
                            protocolName: APIRequestProtocol.self
                        )
                        apiRequestManager.given(
                            .getTopBanners(
                                willReturn: Single.just(topBannerAPIResponse)
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
                            try! target.requestTopBannerDataList().toBlocking().first()
                        ).to(
                            equal(topBannerAPIResponse)
                        )
                    }
                }
            }
        }
    }

    private func getTopBannerAPIResponse() -> TopBannerAPIResponse {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle(for: type(of: self)).path(forResource: "top_banner_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let topBannerAPIResponse = try? JSONDecoder().decode(TopBannerAPIResponse.self, from: data) else {
            fatalError()
        }
        return topBannerAPIResponse
    }
}
