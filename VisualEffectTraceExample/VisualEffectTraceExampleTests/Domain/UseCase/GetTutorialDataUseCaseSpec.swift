//
//  GetTutorialDataUseCase.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/06/30.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class GetTutorialDataUseCaseSpec: QuickSpec {

    // MARK: - Override

    override func spec() {

        let tutorialRepositoryMock = TutorialRepositoryMock()
        let target = GetTutorialDataUseCase()

        describe("GetTutorialDataUseCase") {

            // MARK: - executeを実行した際のテスト

            describe("#execute") {

                // MEMO: 内部JSONデータ変換処理成功時の想定
                context("内部JSONデータが返却される場合") {
                    let result = getDataList()

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        tutorialRepositoryMock.given(
                            .getDataList(
                                willReturn: result
                            )
                        )
                    }

                    it("StubのJSON値を変換したものをそのまま返却すること") {
                        expect(
                            target.execute()
                        ).to(
                            equal(result)
                        )
                    }
                }
            }
        }
    }

    private func getDataList() -> Array<TutorialEntity> {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle.main.path(forResource: "tutorial_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let tutorialDataList = try? JSONDecoder().decode(Array<TutorialEntity>.self, from: data) else {
            fatalError()
        }
        return tutorialDataList
    }
}
