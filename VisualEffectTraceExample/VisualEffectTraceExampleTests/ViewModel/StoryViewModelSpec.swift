//
//  StoryViewModelSpec.swift
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

final class StoryViewModelSpec: QuickSpec {

    // MARK: - Override

    // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let storyUseCase = StoryUseCaseMock()

        // MARK: - initialFetchTriggerを実行した際のテスト

        // MEMO: サーバーから表示内容を取得する場合
        describe("#initialFetchTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let storyAPIResponse = getStoryAPIResponse()

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: storyUseCase,
                        protocolName: StoryUseCase.self
                    )
                    storyUseCase.given(
                        .execute(
                            willReturn: Single.just(storyAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: StoryUseCase.self
                    )
                }
                it("viewModel.outputs.storyItemsが取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = StoryViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.storyItems.toBlocking().first()).to(equal(storyAPIResponse.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーへの登録処理が失敗した場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: storyUseCase,
                        protocolName: StoryUseCase.self
                    )
                    storyUseCase.given(
                        .execute(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: StoryUseCase.self
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: StoryUseCase.self
                    )
                }
                it("viewModel.outputs.storyItemsが取得データが空配列＆viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = StoryViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.storyItems.toBlocking().first()).to(equal([]))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.error))
                }
            }
        }

        // MARK: - undoAPIRequestStateTriggerを実行した際のテスト

        // MEMO: APIRequestStateを元に戻す場合
        describe("#undoAPIRequestStateTrigger") {
            context("APIリクエスト結果ダイアログ表示後に画面状態を元に戻す場合") {
                it("viewModel.outputs.requestStatusがAPIRequestState.noneとなること") {
                    let target = StoryViewModel()
                    target.inputs.undoAPIRequestStateTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.none))
                }
            }
        }
    }

    private func getStoryAPIResponse() -> StoryAPIResponse {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle(for: type(of: self)).path(forResource: "story_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let storyAPIResponse = try? JSONDecoder().decode(StoryAPIResponse.self, from: data) else {
            fatalError()
        }
        return storyAPIResponse
    }
}
