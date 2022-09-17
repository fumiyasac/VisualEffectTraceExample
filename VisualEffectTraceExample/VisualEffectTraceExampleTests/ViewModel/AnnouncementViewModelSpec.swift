//
//  AnnouncementViewModelSpec.swift
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

final class AnnouncementViewModelSpec: QuickSpec {

    // MARK: - Override

    // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let announcementUseCase = AnnouncementUseCaseMock()

        // MARK: - initialFetchTriggerを実行した際のテスト

        // MEMO: サーバーから表示内容を取得する場合
        describe("#initialFetchTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let announcementListAPIResponse = getAnnouncementListAPIResponse()

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: announcementUseCase,
                        protocolName: AnnouncementUseCase.self
                    )
                    announcementUseCase.given(
                        .execute(
                            willReturn: Single.just(announcementListAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: AnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.announcementItemsが取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = AnnouncementViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.announcementItems.toBlocking().first()).to(equal(announcementListAPIResponse.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーからの取得処理が失敗した場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: announcementUseCase,
                        protocolName: AnnouncementUseCase.self
                    )
                    announcementUseCase.given(
                        .execute(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: AnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.announcementItemsが取得データが空配列＆viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = AnnouncementViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.announcementItems.toBlocking().first()).to(equal([]))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.error))
                }
            }
        }

        // MARK: - pullToRefreshTriggerを実行した際のテスト

        // MEMO: サーバーから表示内容を取得する場合
        describe("#pullToRefreshTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let announcementListAPIResponse = getAnnouncementListAPIResponse()

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: announcementUseCase,
                        protocolName: AnnouncementUseCase.self
                    )
                    announcementUseCase.given(
                        .execute(
                            willReturn: Single.just(announcementListAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: AnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.announcementItemsが取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = AnnouncementViewModel()
                    target.inputs.pullToRefreshTrigger.onNext(())
                    expect(try! target.outputs.announcementItems.toBlocking().first()).to(equal(announcementListAPIResponse.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーからの取得処理が失敗した場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: announcementUseCase,
                        protocolName: AnnouncementUseCase.self
                    )
                    announcementUseCase.given(
                        .execute(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: AnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.announcementItemsが取得データが空配列＆viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = AnnouncementViewModel()
                    target.inputs.pullToRefreshTrigger.onNext(())
                    expect(try! target.outputs.announcementItems.toBlocking().first()).to(equal([]))
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
                        mockInstance: announcementUseCase,
                        protocolName: AnnouncementUseCase.self
                    )
                    announcementUseCase.given(
                        .execute(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: AnnouncementUseCase.self
                    )
                }
                it("viewModel.outputs.requestStatusがAPIRequestState.noneとなること") {
                    let target = AnnouncementViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    target.inputs.undoAPIRequestStateTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.none))
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
