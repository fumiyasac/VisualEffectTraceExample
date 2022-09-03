//
//  TopBannerViewModelSpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/07/31.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class TopBannerViewModelSpec: QuickSpec {

    // MARK: - Override

    // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let topBannerUseCase = TopBannerUseCaseMock()

        // MARK: - initialFetchTriggerを実行した際のテスト

        // MEMO: サーバーから表示内容を取得する場合
        describe("#initialFetchTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let topBannerAPIResponse = getTopBannerAPIResponse()

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: topBannerUseCase,
                        protocolName: TopBannerUseCase.self
                    )
                    topBannerUseCase.given(
                        .execute(
                            willReturn: Single.just(topBannerAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: TopBannerUseCase.self
                    )
                }
                it("viewModel.outputs.topBannerItemsが取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = TopBannerViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.topBannerItems.toBlocking().first()).to(equal(topBannerAPIResponse.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーへの登録処理が失敗した場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: topBannerUseCase,
                        protocolName: TopBannerUseCase.self
                    )
                    topBannerUseCase.given(
                        .execute(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: TopBannerUseCase.self
                    )
                }
                it("viewModel.outputs.topBannerItemsが取得データが空配列＆viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = TopBannerViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.topBannerItems.toBlocking().first()).to(equal([]))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.error))
                }
            }
        }

        // MARK: - pullToRefreshTriggerを実行した際のテスト

        // MEMO: PullToRefreshでサーバーから表示内容を取得する場合
        describe("#pullToRefreshTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let topBannerAPIResponse = getTopBannerAPIResponse()

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: topBannerUseCase,
                        protocolName: TopBannerUseCase.self
                    )
                    topBannerUseCase.given(
                        .execute(
                            willReturn: Single.just(topBannerAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: TopBannerUseCase.self
                    )
                }
                it("viewModel.outputs.topBannerItemsが取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = TopBannerViewModel()
                    target.inputs.pullToRefreshTrigger.onNext(())
                    expect(try! target.outputs.topBannerItems.toBlocking().first()).to(equal(topBannerAPIResponse.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーへの登録処理が失敗した場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: topBannerUseCase,
                        protocolName: TopBannerUseCase.self
                    )
                    topBannerUseCase.given(
                        .execute(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: TopBannerUseCase.self
                    )
                }
                it("viewModel.outputs.topBannerItemsが取得データが空配列＆viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = TopBannerViewModel()
                    target.inputs.pullToRefreshTrigger.onNext(())
                    expect(try! target.outputs.topBannerItems.toBlocking().first()).to(equal([]))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.error))
                }
            }
        }

        // MARK: - undoAPIRequestStateTriggerを実行した際のテスト

        // MEMO: APIRequestStateを元に戻す場合
        describe("#undoAPIRequestStateTrigger") {
            context("エラー画面表示からリトライ処理を実施する準備としてAPIRequestStateを.errorから.noneに変更する場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: topBannerUseCase,
                        protocolName: TopBannerUseCase.self
                    )
                    topBannerUseCase.given(
                        .execute(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: TopBannerUseCase.self
                    )
                }
                it("viewModel.outputs.requestStatusがAPIRequestState.noneとなること") {
                    let target = TopBannerViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    target.inputs.undoAPIRequestStateTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.none))
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
