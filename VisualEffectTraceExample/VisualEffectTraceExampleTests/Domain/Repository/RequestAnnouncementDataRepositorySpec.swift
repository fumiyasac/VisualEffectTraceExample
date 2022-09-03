//
//  RequestAnnouncementDataRepositorySpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/06/13.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class RequestAnnouncementDataRepositorySpec: QuickSpec {

    // MARK: - Override

    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let apiRequestManager = APIRequestProtocolMock()
        let target = RequestAnnouncementDataRepository()

        describe("RequestAnnouncementDataRepository") {

            // MARK: - requestAnnouncementDataListを実行した際のテスト

            describe("#requestAnnouncementDataList") {

                // MEMO: API通信処理成功時の想定
                context("APIから正常にデータが返却される場合") {
                    let announcementListAPIResponse = getAnnouncementListAPIResponse()

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: apiRequestManager,
                            protocolName: APIRequestProtocol.self
                        )
                        apiRequestManager.given(
                            .getAnnouncements(
                                willReturn: Single.just(announcementListAPIResponse)
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
                            try! target.requestAnnouncementDataList().toBlocking().first()
                        ).to(
                            equal(announcementListAPIResponse)
                        )
                    }
                }
            }
        }
    }

    private func getAnnouncementListAPIResponse() -> AnnouncementListAPIResponse {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle(for: type(of: self)).path(forResource: "announcement_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let result = try? JSONDecoder().decode(Array<AnnouncementEntity>.self, from: data) else {
            fatalError()
        }
        // MEMO: このAPIのレスポンスだけ少し異なるので注意が必要
        let announcementListAPIResponse = AnnouncementListAPIResponse(result: result)
        return announcementListAPIResponse
    }
}
