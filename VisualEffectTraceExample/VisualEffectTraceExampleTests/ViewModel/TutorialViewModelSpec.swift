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

    // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
    override func spec() {

        let tutorialUseCaseMock = TutorialUseCaseMock()
        let applicationUserStatusUseCaseMock = ApplicationUserStatusUseCaseMock()

        // MARK: - changeIndexTriggerを実行した際のテスト

        // MEMO: スワイプ処理等でTutorialの表示内容を変更する場合
        describe("#changeIndexTrigger") {
            context("changeIndexTrigger実行してindex値が1まで変化させた場合") {
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
                    expect(try! target.outputs.tutorialItems.toBlocking().first()).to(equal(tutorialDataList))
                    expect(try! target.outputs.isLastIndex.toBlocking().first()).to(equal(false))
                }
            }
            context("changeIndexTrigger実行してindex値が2まで変化させた場合") {
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
            context("changeIndexTrigger実行してindex値が3まで変化させた場合") {
                let tutorialDataList = getTutorialDataList()
                beforeEach {
                    tutorialUseCaseMock.given(
                        .execute(
                            willReturn: tutorialDataList
                        )
                    )
                }
                it("executeUpdatePassTutorialStatus()がtrueとなること") {
                    let target = TutorialViewModel()
                    target.inputs.changeIndexTrigger.onNext(1)
                    target.inputs.changeIndexTrigger.onNext(2)
                    target.inputs.changeIndexTrigger.onNext(3)
                    expect(try! target.outputs.tutorialItems.toBlocking().first()).to(equal(tutorialDataList))
                    expect(try! target.outputs.isLastIndex.toBlocking().first()).to(equal(true))
                }
            }
        }

        // MARK: - completeTutorialTriggerを実行した際のテスト

        // MEMO: チュートリアル完了ボタンを押下した場合
        // FIXME: ApplicationUserStatusUseCase以降のUnitTestを書いたらコメントイン
//        describe("#completeTutorialTrigger") {
//            context("チュートリアルを完了した場合") {
//                it("チュートリアル完了ステータス更新処理が1回実行されること") {
//                    let target = TutorialViewModel()
//                    target.inputs.completeTutorialTrigger.onNext(())
//                    applicationUserStatusUseCaseMock.verify(
//                        .executeUpdatePassTutorialStatus(),
//                        count: .once
//                    )
//                }
//            }
//        }
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
