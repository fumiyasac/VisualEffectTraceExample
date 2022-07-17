//
//  MainViewModelSpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/07/17.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class MainViewModelSpec: QuickSpec {

    // MARK: - Override

    // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let mainScreenUseCase = MainScreenUseCaseMock()

        // MARK: - initialSettingTriggerを実行した際のテスト
        
        // MEMO: 画面表示時の表示内容を変更する場合
        describe("#initialSettingTrigger") {
            context("画面起動時以降に表示対象画面を決定する場合") {
                let applicationUserStatus = ApplicationUserStatus.needToMoveGlobalTabBarScreen
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: mainScreenUseCase,
                        protocolName: MainScreenUseCase.self
                    )
                    mainScreenUseCase.given(
                        .execute(
                            willReturn: applicationUserStatus
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: MainScreenUseCase.self
                    )
                }
                it("targetApplicationUserStateがApplicationUserStatus.needToMoveGlobalTabBarScreenとなること") {
                    let target = MainViewModel()
                    target.inputs.initialSettingTrigger.onNext(())
                    expect(try! target.outputs.targetApplicationUserState.toBlocking().first()).to(equal(applicationUserStatus))
                }
            }
        }
    }
}
