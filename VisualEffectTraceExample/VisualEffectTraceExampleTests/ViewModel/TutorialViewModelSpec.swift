//
//  TutorialViewModelSpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/07/09.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class TutorialViewModelSpec: QuickSpec {

    // MARK: - Override

    override func spec() {

        let tutorialUseCaseMock = TutorialUseCaseMock()

        // MARK: - changeIndexTriggerを実行した際のテスト

        // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
        describe("#changeIndexTrigger") {
            // MEMO: スワイプ処理等でTutorialの表示内容を変更する場合
            context("changeIndexTrigger実行時かつindex値が2以下の場合") {
                let tutorialDataList = getTutorialDataList()
                beforeEach {
                    tutorialUseCaseMock.given(
                        .execute(
                            willReturn: tutorialDataList
                        )
                    )
                }
                it("isLastIndexがfalseとなること") {
                    let target = TutorialViewModel()
                    target.inputs.changeIndexTrigger.onNext(1)
                    target.inputs.changeIndexTrigger.onNext(2)
                    expect(try! target.outputs.tutorialItems.toBlocking().first()).to(equal(tutorialDataList))
                    expect(try! target.outputs.isLastIndex.toBlocking().first()).to(equal(false))
                }
            }
            context("changeIndexTrigger実行時かつindex値が3の場合") {
                let tutorialDataList = getTutorialDataList()
                beforeEach {
                    tutorialUseCaseMock.given(
                        .execute(
                            willReturn: tutorialDataList
                        )
                    )
                }
                it("isLastIndexがtrueとなること") {
                    let target = TutorialViewModel()
                    target.inputs.changeIndexTrigger.onNext(1)
                    target.inputs.changeIndexTrigger.onNext(2)
                    target.inputs.changeIndexTrigger.onNext(3)
                    expect(try! target.outputs.tutorialItems.toBlocking().first()).to(equal(tutorialDataList))
                    expect(try! target.outputs.isLastIndex.toBlocking().first()).to(equal(true))
                }
            }
        }
    }

    private func getTutorialDataList() -> Array<TutorialEntity> {

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
