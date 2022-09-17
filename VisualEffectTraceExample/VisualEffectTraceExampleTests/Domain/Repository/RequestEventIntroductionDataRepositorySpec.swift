//
//  RequestEventIntroductionDataRepositorySpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/09/17.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class RequestEventIntroductionDataRepositorySpec: QuickSpec {
    
    // MARK: - Override
    
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let apiRequestManager = APIRequestProtocolMock()
        let target = RequestEventIntroductionDataRepository()

        describe("RequestEventIntroductionDataRepository") {

            // MARK: - requestEventIntroductionDataListを実行した際のテスト

            describe("#requestEventIntroductionDataList") {

                // MEMO: API通信処理成功時の想定
                context("APIから正常にデータが返却される場合") {
                    let eventIntroductionAPIResponse1 = getEventIntroductionAPIResponse(page: 1)
                    let eventIntroductionAPIResponse2 = getEventIntroductionAPIResponse(page: 2)
                    let eventIntroductionAPIResponse3 = getEventIntroductionAPIResponse(page: 3)
                    let eventIntroductionAPIResponse4 = getEventIntroductionAPIResponse(page: 4)

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: apiRequestManager,
                            protocolName: APIRequestProtocol.self
                        )
                        apiRequestManager.given(
                            .getEventIntroductionsBy(
                                page: .value(1),
                                willReturn: Single.just(eventIntroductionAPIResponse1)
                            )
                        )
                        apiRequestManager.given(
                            .getEventIntroductionsBy(
                                page: .value(2),
                                willReturn: Single.just(eventIntroductionAPIResponse2)
                            )
                        )
                        apiRequestManager.given(
                            .getEventIntroductionsBy(
                                page: .value(3),
                                willReturn: Single.just(eventIntroductionAPIResponse3)
                            )
                        )
                        apiRequestManager.given(
                            .getEventIntroductionsBy(
                                page: .value(4),
                                willReturn: Single.just(eventIntroductionAPIResponse4)
                            )
                        )
                    }
                    afterEach {
                        testingDependency.removeIndividualMock(
                            protocolName: APIRequestProtocol.self
                        )
                    }
                    it("StubのJSON値を変換したものをそのまま返却すること(page=1〜4)") {
                        expect(
                            try! target.requestEventIntroductionDataList(page: 1).toBlocking().first()
                        ).to(
                            equal(eventIntroductionAPIResponse1)
                        )
                        expect(
                            try! target.requestEventIntroductionDataList(page: 2).toBlocking().first()
                        ).to(
                            equal(eventIntroductionAPIResponse2)
                        )
                        expect(
                            try! target.requestEventIntroductionDataList(page: 3).toBlocking().first()
                        ).to(
                            equal(eventIntroductionAPIResponse3)
                        )
                        expect(
                            try! target.requestEventIntroductionDataList(page: 4).toBlocking().first()
                        ).to(
                            equal(eventIntroductionAPIResponse4)
                        )
                    }
                }
            }
        }
    }

    private func getEventIntroductionAPIResponse(page: Int) -> EventIntroductionAPIResponse {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle(for: type(of: self)).path(forResource: "event_introduction_page\(page)_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let eventIntroductionAPIResponse = try? JSONDecoder().decode(EventIntroductionAPIResponse.self, from: data) else {
            fatalError()
        }
        return eventIntroductionAPIResponse
    }
}
