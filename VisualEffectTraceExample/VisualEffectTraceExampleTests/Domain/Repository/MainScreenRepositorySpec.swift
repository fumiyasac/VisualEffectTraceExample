//
//  MainScreenRepositorySpec.swift
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

final class MainScreenRepositorySpec: QuickSpec {

    // MARK: - Override

    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let realmAccessManager = RealmAccessProtocolMock()
        let keychainAccessManager = KeychainAccessProtocolMock()
        let target = MainScreenRepository()

        describe("MainScreenRepository") {

            // MARK: - searchApplicationUserDataを実行した際のテスト

            describe("#searchApplicationUserData") {

                // MEMO: チュートリアル画面を表示する想定
                context("チュートリアル画面へ遷移する場合") {
                    let applicationUserEntity = ApplicationUserEntity()
                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: realmAccessManager,
                            protocolName: RealmAccessProtocol.self
                        )
                        testingDependency.injectIndividualMock(
                            mockInstance: keychainAccessManager,
                            protocolName: KeychainAccessProtocol.self
                        )
                        realmAccessManager.given(
                            .getApplicationUser(
                                willReturn: applicationUserEntity
                            )
                        )
                        keychainAccessManager.given(
                            .existsJsonAccessToken(
                                willReturn: false
                            )
                        )
                    }
                    afterEach {
                        testingDependency.removeIndividualMock(
                            protocolName: RealmAccessProtocol.self
                        )
                        testingDependency.removeIndividualMock(
                            protocolName: KeychainAccessProtocol.self
                        )
                    }
                    it("ApplicationUserStatus.needToMoveTutorialScreenを返却すること") {
                        expect(target.searchApplicationUserData()).to(equal(ApplicationUserStatus.needToMoveTutorialScreen))
                    }
                }

                // MEMO: サインイン画面を表示する想定
                context("サインイン画面へ遷移する場合") {
                    let applicationUserEntity = ApplicationUserEntity()
                    applicationUserEntity.alreadyPassTutorial = true
                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: realmAccessManager,
                            protocolName: RealmAccessProtocol.self
                        )
                        testingDependency.injectIndividualMock(
                            mockInstance: keychainAccessManager,
                            protocolName: KeychainAccessProtocol.self
                        )
                        realmAccessManager.given(
                            .getApplicationUser(
                                willReturn: applicationUserEntity
                            )
                        )
                        keychainAccessManager.given(
                            .existsJsonAccessToken(
                                willReturn: false
                            )
                        )
                    }
                    afterEach {
                        testingDependency.removeIndividualMock(
                            protocolName: RealmAccessProtocol.self
                        )
                        testingDependency.removeIndividualMock(
                            protocolName: KeychainAccessProtocol.self
                        )
                    }
                    it("ApplicationUserStatus.needToMoveSigninScreenを返却すること") {
                        expect(target.searchApplicationUserData()).to(equal(ApplicationUserStatus.needToMoveSigninScreen))
                    }
                }

                // MEMO: メインのタブバー画面を表示する想定
                context("メインのタブバー画面へ遷移する場合") {
                    let applicationUserEntity = ApplicationUserEntity()
                    applicationUserEntity.alreadyPassTutorial = true
                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: realmAccessManager,
                            protocolName: RealmAccessProtocol.self
                        )
                        testingDependency.injectIndividualMock(
                            mockInstance: keychainAccessManager,
                            protocolName: KeychainAccessProtocol.self
                        )
                        realmAccessManager.given(
                            .getApplicationUser(
                                willReturn: applicationUserEntity
                            )
                        )
                        keychainAccessManager.given(
                            .existsJsonAccessToken(
                                willReturn: true
                            )
                        )
                    }
                    afterEach {
                        testingDependency.removeIndividualMock(
                            protocolName: RealmAccessProtocol.self
                        )
                        testingDependency.removeIndividualMock(
                            protocolName: KeychainAccessProtocol.self
                        )
                    }
                    it("ApplicationUserStatus.needToMoveGlobalTabBarScreenを返却すること") {
                        expect(target.searchApplicationUserData()).to(equal(ApplicationUserStatus.needToMoveGlobalTabBarScreen))
                    }
                }

                // MEMO: アプリを初回起動した場合にチュートリアル画面を表示する想定
                context("アプリを初回起動した場合にチュートリアル画面へ遷移する場合") {
                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: realmAccessManager,
                            protocolName: RealmAccessProtocol.self
                        )
                        testingDependency.injectIndividualMock(
                            mockInstance: keychainAccessManager,
                            protocolName: KeychainAccessProtocol.self
                        )
                        realmAccessManager.given(
                            .getApplicationUser(
                                willReturn: nil
                            )
                        )
                        keychainAccessManager.given(
                            .existsJsonAccessToken(
                                willReturn: false
                            )
                        )
                    }
                    afterEach {
                        testingDependency.removeIndividualMock(
                            protocolName: RealmAccessProtocol.self
                        )
                        testingDependency.removeIndividualMock(
                            protocolName: KeychainAccessProtocol.self
                        )
                    }
                    it("ApplicationUserStatus.needToMoveTutorialScreenを返却すること") {
                        expect(target.searchApplicationUserData()).to(equal(ApplicationUserStatus.needToMoveTutorialScreen))
                    }
                }
            }
        }
    }
}
