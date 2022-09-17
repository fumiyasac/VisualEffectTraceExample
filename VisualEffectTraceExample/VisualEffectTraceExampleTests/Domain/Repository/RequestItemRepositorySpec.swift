//
//  RequestItemRepositorySpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/09/18.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class RequestItemRepositorySpec: QuickSpec {

    // MARK: - Override
    
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let apiRequestManager = APIRequestProtocolMock()
        let target = RequestItemRepository()

        describe("RequestItemRepository") {

            // MARK: - requestItemDataListを実行した際のテスト

            describe("#requestItemDataList") {

                // MEMO: API通信処理成功時の想定
                context("APIから正常にデータが返却される場合") {
                    let itemAPIResponse1 = getItemAPIResponse(page: 1)
                    let itemAPIResponse2 = getItemAPIResponse(page: 2)
                    let itemAPIResponse3 = getItemAPIResponse(page: 3)
                    let itemAPIResponse4 = getItemAPIResponse(page: 4)

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: apiRequestManager,
                            protocolName: APIRequestProtocol.self
                        )
                        apiRequestManager.given(
                            .getItemsBy(
                                page: .value(1),
                                willReturn: Single.just(itemAPIResponse1)
                            )
                        )
                        apiRequestManager.given(
                            .getItemsBy(
                                page: .value(2),
                                willReturn: Single.just(itemAPIResponse2)
                            )
                        )
                        apiRequestManager.given(
                            .getItemsBy(
                                page: .value(3),
                                willReturn: Single.just(itemAPIResponse3)
                            )
                        )
                        apiRequestManager.given(
                            .getItemsBy(
                                page: .value(4),
                                willReturn: Single.just(itemAPIResponse4)
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
                            try! target.requestItemDataList(page: 1).toBlocking().first()
                        ).to(
                            equal(itemAPIResponse1)
                        )
                        expect(
                            try! target.requestItemDataList(page: 2).toBlocking().first()
                        ).to(
                            equal(itemAPIResponse2)
                        )
                        expect(
                            try! target.requestItemDataList(page: 3).toBlocking().first()
                        ).to(
                            equal(itemAPIResponse3)
                        )
                        expect(
                            try! target.requestItemDataList(page: 4).toBlocking().first()
                        ).to(
                            equal(itemAPIResponse4)
                        )
                    }
                }
            }
        }
    }
    
    private func getItemAPIResponse(page: Int) -> ItemAPIResponse {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle(for: type(of: self)).path(forResource: "item_page\(page)_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let itemAPIResponse = try? JSONDecoder().decode(ItemAPIResponse.self, from: data) else {
            fatalError()
        }
        return itemAPIResponse
    }
}
