//
//  EventIntroductionViewModelSpec.swift
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

final class EventIntroductionViewModelSpec: QuickSpec {

    // MARK: - Override

    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let eventIntroductionRepository = EventIntroductionRepositoryMock()
        
        // MARK: - initialFetchTriggerを実行した際のテスト

        // MEMO: サーバーから表示内容を取得する場合
        describe("#initialFetchTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let eventIntroductionAPIResponse1 = getEventIntroductionAPIResponse(page: 1)

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: eventIntroductionRepository,
                        protocolName: EventIntroductionRepository.self
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(1),
                            willReturn: Single.just(eventIntroductionAPIResponse1)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: EventIntroductionRepository.self
                    )
                }
                it("viewModel.outputs.eventIntroductionItemsが1ページ分の取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = EventIntroductionViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.eventIntroductionItems.toBlocking().first()).to(equal(eventIntroductionAPIResponse1.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーからの取得処理が失敗した場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: eventIntroductionRepository,
                        protocolName: EventIntroductionRepository.self
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(1),
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: EventIntroductionRepository.self
                    )
                }
                it("viewModel.outputs.eventIntroductionItemsが取得データが空配列＆viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = EventIntroductionViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.eventIntroductionItems.toBlocking().first()).to(equal([]))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.error))
                }
            }
        }

        // MARK: - paginationFetchTriggerを実行した際のテスト

        // MEMO: サーバーから表示内容を取得する場合
        describe("#paginationFetchTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let eventIntroductionAPIResponse1 = getEventIntroductionAPIResponse(page: 1)
                let eventIntroductionAPIResponse2 = getEventIntroductionAPIResponse(page: 2)
                let eventIntroductionAPIResponse3 = getEventIntroductionAPIResponse(page: 3)
                let eventIntroductionAPIResponse4 = getEventIntroductionAPIResponse(page: 4)

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: eventIntroductionRepository,
                        protocolName: EventIntroductionRepository.self
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(1),
                            willReturn: Single.just(eventIntroductionAPIResponse1)
                        )
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(2),
                            willReturn: Single.just(eventIntroductionAPIResponse2)
                        )
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(3),
                            willReturn: Single.just(eventIntroductionAPIResponse3)
                        )
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(4),
                            willReturn: Single.just(eventIntroductionAPIResponse4)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: EventIntroductionRepository.self
                    )
                }
                it("viewModel.outputs.eventIntroductionItemsが1ページ分〜4ページ分が取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = EventIntroductionViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    for _ in 2...4 {
                        target.inputs.paginationFetchTrigger.onNext(())
                    }
                    let expected = eventIntroductionAPIResponse1.result
                        + eventIntroductionAPIResponse2.result
                        + eventIntroductionAPIResponse3.result
                        + eventIntroductionAPIResponse4.result
                    expect(try! target.outputs.eventIntroductionItems.toBlocking().first()).to(equal(expected))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーからの取得処理が失敗した場合") {
                let eventIntroductionAPIResponse1 = getEventIntroductionAPIResponse(page: 1)
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: eventIntroductionRepository,
                        protocolName: EventIntroductionRepository.self
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(1),
                            willReturn: Single.just(eventIntroductionAPIResponse1)
                        )
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(2),
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: EventIntroductionRepository.self
                    )
                }
                // MEMO: paginationFetchTriggerを発火させる場合はエラー画面を表示する必要がないので(ignoreError = true)としている。
                it("viewModel.outputs.eventIntroductionItemsが取得データが1ページ分の取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.noneとなること") {
                    let target = EventIntroductionViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    target.inputs.paginationFetchTrigger.onNext(())
                    expect(try! target.outputs.eventIntroductionItems.toBlocking().first()).to(equal(eventIntroductionAPIResponse1.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.none))
                }
            }
        }

        // MARK: - pullToRefreshTriggerを実行した際のテスト

        // MEMO: PullToRefreshでサーバーから表示内容を取得する場合
        describe("#pullToRefreshTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let eventIntroductionAPIResponse1 = getEventIntroductionAPIResponse(page: 1)
                let eventIntroductionAPIResponse2 = getEventIntroductionAPIResponse(page: 2)
                let eventIntroductionAPIResponse3 = getEventIntroductionAPIResponse(page: 3)
                let eventIntroductionAPIResponse4 = getEventIntroductionAPIResponse(page: 4)

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: eventIntroductionRepository,
                        protocolName: EventIntroductionRepository.self
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(1),
                            willReturn: Single.just(eventIntroductionAPIResponse1)
                        )
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(2),
                            willReturn: Single.just(eventIntroductionAPIResponse2)
                        )
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(3),
                            willReturn: Single.just(eventIntroductionAPIResponse3)
                        )
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(4),
                            willReturn: Single.just(eventIntroductionAPIResponse4)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: EventIntroductionRepository.self
                    )
                }
                it("viewModel.outputs.eventIntroductionItemsが1ページ分の取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = EventIntroductionViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    for _ in 2...4 {
                        target.inputs.paginationFetchTrigger.onNext(())
                    }
                    target.inputs.pullToRefreshTrigger.onNext(())
                    expect(try! target.outputs.eventIntroductionItems.toBlocking().first()).to(equal(eventIntroductionAPIResponse1.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
        }

        // MARK: - undoAPIRequestStateTriggerを実行した際のテスト

        // MEMO: APIRequestStateを元に戻す場合
        describe("#undoAPIRequestStateTrigger") {
            context("エラー画面表示からリトライ処理を実施する準備としてAPIRequestStateを.errorから.noneに変更する場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: eventIntroductionRepository,
                        protocolName: EventIntroductionRepository.self
                    )
                    eventIntroductionRepository.given(
                        .requestEventIntroductionDataList(
                            page: .value(1),
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: EventIntroductionRepository.self
                    )
                }
                it("viewModel.outputs.requestStatusがAPIRequestState.noneとなること") {
                    let target = EventIntroductionViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    target.inputs.undoAPIRequestStateTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.none))
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
