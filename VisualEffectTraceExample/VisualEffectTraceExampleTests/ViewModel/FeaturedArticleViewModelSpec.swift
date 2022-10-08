//
//  FeaturedArticleViewModelSpec.swift
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

final class FeaturedArticleViewModelSpec: QuickSpec {

    // MARK: - Override

    // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let featuredArticleRepository = FeaturedArticleRepositoryMock()

        // MARK: - initialFetchTriggerを実行した際のテスト

        // MEMO: サーバーから表示内容を取得する場合
        describe("#initialFetchTrigger") {
            context("サーバーからの取得処理が成功した場合") {
                let featuredArticleAPIResponse = getFeaturedArticleAPIResponse()

                // Mockに差し替えたメソッドが返却する値を定める
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: featuredArticleRepository,
                        protocolName: FeaturedArticleRepository.self
                    )
                    featuredArticleRepository.given(
                        .requestFeaturedArticleDataList(
                            willReturn: Single.just(featuredArticleAPIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: FeaturedArticleRepository.self
                    )
                }
                it("viewModel.outputs.featuredArticleItemsが取得データと一致する＆viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = FeaturedArticleViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.featuredArticleItems.toBlocking().first()).to(equal(featuredArticleAPIResponse.result))
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーからの取得処理が失敗した場合") {
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: featuredArticleRepository,
                        protocolName: FeaturedArticleRepository.self
                    )
                    featuredArticleRepository.given(
                        .requestFeaturedArticleDataList(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: FeaturedArticleRepository.self
                    )
                }
                it("viewModel.outputs.featuredArticleItemsが取得データが空配列＆viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = FeaturedArticleViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    expect(try! target.outputs.featuredArticleItems.toBlocking().first()).to(equal([]))
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
                        mockInstance: featuredArticleRepository,
                        protocolName: FeaturedArticleRepository.self
                    )
                    featuredArticleRepository.given(
                        .requestFeaturedArticleDataList(
                            willReturn: Single.error(CommonError.invalidResponse("データの取得に失敗しました。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: FeaturedArticleRepository.self
                    )
                }
                it("viewModel.outputs.requestStatusがAPIRequestState.noneとなること") {
                    let target = FeaturedArticleViewModel()
                    target.inputs.initialFetchTrigger.onNext(())
                    target.inputs.undoAPIRequestStateTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.none))
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
