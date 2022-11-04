//
//  SigninViewModelSpec.swift
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

final class SigninViewModelSpec: QuickSpec {

    // MARK: - Override

    // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let signinRepository = SigninRepositoryMock()
        let applicationUserRepository = ApplicationUserRepositoryMock()

        // MARK: - inputMailAddressTriggerを実行した際のテスト

        describe("#inputMailAddressTrigger") {
            context("メールアドレスを入力した場合") {
                let mailAddress: String = "fumiya.sakai@example.com"
                it("viewModel.outputs.mailAddressへ入力値が反映されること") {
                    let target = SigninViewModel()
                    target.inputs.inputMailAddressTrigger.onNext(mailAddress)
                    expect(try! target.outputs.mailAddress.toBlocking().first()).to(equal(mailAddress))
                }
            }
        }

        // MARK: - inputRawPasswordTriggerを実行した際のテスト

        describe("#inputRawPasswordTrigger") {
            context("パスワードを入力した場合") {
                let rawPassword: String = "testcode1234"
                it("viewModel.outputs.rawPasswordへ入力値が反映されること") {
                    let target = SigninViewModel()
                    target.inputs.inputRawPasswordTrigger.onNext(rawPassword)
                    expect(try! target.outputs.rawPassword.toBlocking().first()).to(equal(rawPassword))
                }
            }
        }

        // MARK: - executeSigninRequestTriggerを実行した際のテスト

        // MEMO: サーバーへ入力内容を送信する場合
        describe("#executeSigninRequestTrigger") {
            context("サーバーへの登録処理が成功した場合") {
                let mailAddress: String = "fumiya.sakai@example.com"
                let rawPassword: String = "testcode1234"
                let signinSuccessResponse = SigninSuccessResponse(
                    result: "OK",
                    token: "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJmdW1peWFzYWMiLCJleHAiOjE2NTgxMzAyMDB9.UQnRp8gM-qhWN8lfsYIEasluc7MjHjRYjwutLALSr8rzXxaAaaG6cJ7GmDK1ERg068KdAGRoih2-CQFy9B_ibA"
                )
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: applicationUserRepository,
                        protocolName: ApplicationUserRepository.self
                    )
                    testingDependency.injectIndividualMock(
                        mockInstance: signinRepository,
                        protocolName: SigninRepository.self
                    )
                    signinRepository.given(
                        .requestSignin(
                            mailAddress: .value(mailAddress),
                            rawPassword: .value(rawPassword),
                            willReturn: Single.just(signinSuccessResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: ApplicationUserRepository.self
                    )
                    testingDependency.removeIndividualMock(
                        protocolName: SigninRepository.self
                    )
                }
                it("viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = SigninViewModel()
                    target.inputs.inputMailAddressTrigger.onNext(mailAddress)
                    target.inputs.inputRawPasswordTrigger.onNext(rawPassword)
                    target.inputs.executeSigninRequestTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーへの登録処理が失敗した場合") {
                let mailAddress: String = "fumiya.sakai@example.com"
                let rawPassword: String = "testcode1234"
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: applicationUserRepository,
                        protocolName: ApplicationUserRepository.self
                    )
                    testingDependency.injectIndividualMock(
                        mockInstance: signinRepository,
                        protocolName: SigninRepository.self
                    )
                    signinRepository.given(
                        .requestSignin(
                            mailAddress: .value(mailAddress),
                            rawPassword: .value(rawPassword),
                            willReturn: Single.error(CommonError.invalidResponse("入力したパスワードまたはメールアドレスに誤りがあります。"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: ApplicationUserRepository.self
                    )
                    testingDependency.removeIndividualMock(
                        protocolName: SigninRepository.self
                    )
                }
                it("viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = SigninViewModel()
                    target.inputs.inputMailAddressTrigger.onNext(mailAddress)
                    target.inputs.inputRawPasswordTrigger.onNext(rawPassword)
                    target.inputs.executeSigninRequestTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.error))
                }
            }
        }

        // MARK: - undoAPIRequestStateTriggerを実行した際のテスト

        // MEMO: APIRequestStateを元に戻す場合
        describe("#undoAPIRequestStateTrigger") {
            context("APIリクエスト結果ダイアログ表示後に画面状態を元に戻す場合") {
                it("viewModel.outputs.requestStatusがAPIRequestState.noneとなること") {
                    let target = SigninViewModel()
                    target.inputs.undoAPIRequestStateTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.none))
                }
            }
        }

        // MARK: - clearInputFieldTriggerを実行した際のテスト

        // MEMO: 送信完了した後にTextField値を元に戻す場合
        describe("#clearInputFieldTrigger") {
            context("APIリクエスト結果ダイアログ表示後にTextFieldで入力した変数をクリアする場合") {
                let mailAddress: String = "fumiya.sakai@example.com"
                let rawPassword: String = "testcode1234"
                it("viewModel.outputs.mailAddress及びviewModel.outputs.rawPasswordが空となること") {
                    let target = SigninViewModel()
                    target.inputs.inputMailAddressTrigger.onNext(mailAddress)
                    target.inputs.inputRawPasswordTrigger.onNext(rawPassword)
                    target.inputs.clearInputFieldTrigger.onNext(())
                    expect(try! target.outputs.mailAddress.toBlocking().first()).to(equal(""))
                    expect(try! target.outputs.rawPassword.toBlocking().first()).to(equal(""))
                }
            }
        }
    }
}
