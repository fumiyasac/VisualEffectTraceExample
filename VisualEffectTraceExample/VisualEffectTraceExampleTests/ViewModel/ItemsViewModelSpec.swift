//
//  ItemsViewModelSpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/07/30.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class ItemsViewModelSpec: QuickSpec {
    
    // MARK: - Override
    
    override func spec() {
        
        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()
        
        let itemUseCase = ItemUseCaseMock()
        let recentAnnouncementUseCase = RecentAnnouncementUseCaseMock()
        
        // MARK: - initialFetchTriggerを実行した際のテスト
        
        // MEMO: サーバーから表示内容を取得する場合
        describe("#initialFetchTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let itemAPIResponse1 = getItemAPIResponse(page: 1)
                let announcementDetailAPIResponse = AnnouncementDetailAPIResponse(result: getRecentData())

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: itemUseCase,
                        protocolName: ItemUseCase.self
                    )
                    testingDependency.injectIndividualMock(
                        mockInstance: recentAnnouncementUseCase,
                        protocolName: RecentAnnouncementUseCase.self
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(1),
                            willReturn: Single.just(itemAPIResponse1)
                        )
                    )
                    recentAnnouncementUseCase.given(
                        .execute(
                            willReturn: Single.just(announcementDetailAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: ItemUseCase.self
                    )
                    testingDependency.removeIndividualMock(
                        protocolName: RecentAnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.itemsが1ページ分の取得データと一致する＆viewModel.outputs.recentAnnouncementが1件分の取得データと一致する") {
                    let target = ItemsViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.items.toBlocking().first()).to(equal(itemAPIResponse1.result))
                    expect(try! target.outputs.recentAnnouncement.toBlocking().first()).to(equal(announcementDetailAPIResponse.result))
                }
            }
        }

        // MARK: - paginationFetchTriggerを実行した際のテスト
        
        // MEMO: サーバーから表示内容を取得する場合
        describe("#paginationFetchTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let itemAPIResponse1 = getItemAPIResponse(page: 1)
                let itemAPIResponse2 = getItemAPIResponse(page: 2)
                let itemAPIResponse3 = getItemAPIResponse(page: 3)
                let itemAPIResponse4 = getItemAPIResponse(page: 4)
                let announcementDetailAPIResponse = AnnouncementDetailAPIResponse(result: getRecentData())

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: itemUseCase,
                        protocolName: ItemUseCase.self
                    )
                    testingDependency.injectIndividualMock(
                        mockInstance: recentAnnouncementUseCase,
                        protocolName: RecentAnnouncementUseCase.self
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(1),
                            willReturn: Single.just(itemAPIResponse1)
                        )
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(2),
                            willReturn: Single.just(itemAPIResponse2)
                        )
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(3),
                            willReturn: Single.just(itemAPIResponse3)
                        )
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(4),
                            willReturn: Single.just(itemAPIResponse4)
                        )
                    )
                    recentAnnouncementUseCase.given(
                        .execute(
                            willReturn: Single.just(announcementDetailAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: ItemUseCase.self
                    )
                    testingDependency.removeIndividualMock(
                        protocolName: RecentAnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.itemsが1ページ分〜4ページ分の取得データと一致する＆viewModel.outputs.recentAnnouncementが1件分の取得データと一致する") {
                    let target = ItemsViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    for _ in 2...4 {
                        target.inputs.paginationFetchTrigger.onNext(())
                    }
                    let expected = itemAPIResponse1.result
                    + itemAPIResponse2.result
                    + itemAPIResponse3.result
                    + itemAPIResponse4.result
                    expect(try! target.outputs.items.toBlocking().first()).to(equal(expected))
                    expect(try! target.outputs.recentAnnouncement.toBlocking().first()).to(equal(announcementDetailAPIResponse.result))
                }
            }
            context("サーバーからの取得処理が失敗した場合") {
                let itemAPIResponse1 = getItemAPIResponse(page: 1)
                let announcementDetailAPIResponse = AnnouncementDetailAPIResponse(result: getRecentData())
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: itemUseCase,
                        protocolName: ItemUseCase.self
                    )
                    testingDependency.injectIndividualMock(
                        mockInstance: recentAnnouncementUseCase,
                        protocolName: RecentAnnouncementUseCase.self
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(1),
                            willReturn: Single.just(itemAPIResponse1)
                        )
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(2),
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                    recentAnnouncementUseCase.given(
                        .execute(
                            willReturn: Single.just(announcementDetailAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: ItemUseCase.self
                    )
                    testingDependency.removeIndividualMock(
                        protocolName: RecentAnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.itemsが1ページ分の取得データと一致する＆viewModel.outputs.recentAnnouncementが1件分の取得データと一致する") {
                    let target = ItemsViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    target.inputs.paginationFetchTrigger.onNext(())
                    expect(try! target.outputs.items.toBlocking().first()).to(equal(itemAPIResponse1.result))
                    expect(try! target.outputs.recentAnnouncement.toBlocking().first()).to(equal(announcementDetailAPIResponse.result))
                }
            }
        }

        // MARK: - pullToRefreshTriggerを実行した際のテスト

        // MEMO: PullToRefreshでサーバーから表示内容を取得する場合
        describe("#pullToRefreshTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let itemAPIResponse1 = getItemAPIResponse(page: 1)
                let itemAPIResponse2 = getItemAPIResponse(page: 2)
                let itemAPIResponse3 = getItemAPIResponse(page: 3)
                let itemAPIResponse4 = getItemAPIResponse(page: 4)
                let announcementDetailAPIResponse = AnnouncementDetailAPIResponse(result: getRecentData())

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: itemUseCase,
                        protocolName: ItemUseCase.self
                    )
                    testingDependency.injectIndividualMock(
                        mockInstance: recentAnnouncementUseCase,
                        protocolName: RecentAnnouncementUseCase.self
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(1),
                            willReturn: Single.just(itemAPIResponse1)
                        )
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(2),
                            willReturn: Single.just(itemAPIResponse2)
                        )
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(3),
                            willReturn: Single.just(itemAPIResponse3)
                        )
                    )
                    itemUseCase.given(
                        .execute(
                            page: .value(4),
                            willReturn: Single.just(itemAPIResponse4)
                        )
                    )
                    recentAnnouncementUseCase.given(
                        .execute(
                            willReturn: Single.just(announcementDetailAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: ItemUseCase.self
                    )
                    testingDependency.removeIndividualMock(
                        protocolName: RecentAnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.itemsが1ページ分の取得データと一致する＆viewModel.outputs.recentAnnouncementが1件分の取得データと一致する") {
                    let target = ItemsViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    for _ in 2...4 {
                        target.inputs.paginationFetchTrigger.onNext(())
                    }
                    target.inputs.pullToRefreshTrigger.onNext(())
                    expect(try! target.outputs.items.toBlocking().first()).to(equal(itemAPIResponse1.result))
                    expect(try! target.outputs.recentAnnouncement.toBlocking().first()).to(equal(announcementDetailAPIResponse.result))
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

    private func getRecentData() -> AnnouncementEntity {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle(for: type(of: self)).path(forResource: "announcement_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let announcementDataList = try? JSONDecoder().decode(Array<AnnouncementEntity>.self, from: data) else {
            fatalError()
        }
        guard let recentData = announcementDataList.last else {
            fatalError()
        }
        return recentData
    }
}
