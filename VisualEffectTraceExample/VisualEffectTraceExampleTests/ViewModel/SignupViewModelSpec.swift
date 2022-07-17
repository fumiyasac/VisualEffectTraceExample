//
//  SignupViewModelSpec.swift
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

final class SignupViewModelSpec: QuickSpec {

    // MARK: - Override

    // MEMO: ViewModelクラス内のInput&Outputの変化が検知できていることを確認する
    override func spec() {

        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let signupUseCase = SignupUsecaseMock()

        // MARK: - inputUserNameTriggerを実行した際のテスト

        // MEMO: 画面表示時の表示内容を入力する場合
        describe("#inputUserNameTrigger") {
            context("ユーザー名を入力した場合") {
                let userName: String = "fumiyasac"
                it("viewModel.outputs.userNameへ入力値が反映されること") {
                    let target = SignupViewModel()
                    target.inputs.inputUserNameTrigger.onNext(userName)
                    expect(try! target.outputs.userName.toBlocking().first()).to(equal(userName))
                }
            }
        }

        // MARK: - inputMailAddressTriggerを実行した際のテスト

        describe("#inputMailAddressTrigger") {
            context("メールアドレスを入力した場合") {
                let mailAddress: String = "fumiya.sakai@example.com"
                it("viewModel.outputs.mailAddressへ入力値が反映されること") {
                    let target = SignupViewModel()
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
                    let target = SignupViewModel()
                    target.inputs.inputRawPasswordTrigger.onNext(rawPassword)
                    expect(try! target.outputs.rawPassword.toBlocking().first()).to(equal(rawPassword))
                }
            }
        }

        // MARK: - executeSignupRequestTriggerを実行した際のテスト

        // MEMO: サーバーへ入力内容を送信する場合
        describe("#executeSignupRequestTrigger") {
            context("サーバーへの登録処理が成功した場合") {
                let userName: String = "fumiyasac"
                let mailAddress: String = "fumiya.sakai@example.com"
                let rawPassword: String = "testcode1234"
                let generalPostSuccessARIResponse = GeneralPostSuccessARIResponse(result: "OK")
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: signupUseCase,
                        protocolName: SignupUsecase.self
                    )
                    signupUseCase.given(
                        .execute(
                            userName: .value(userName),
                            mailAddress: .value(mailAddress),
                            rawPassword: .value(rawPassword),
                            willReturn: Single.just(generalPostSuccessARIResponse)
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: SignupUsecase.self
                    )
                }
                it("viewModel.outputs.requestStatusがAPIRequestState.successとなること") {
                    let target = SignupViewModel()
                    target.inputs.inputUserNameTrigger.onNext(userName)
                    target.inputs.inputMailAddressTrigger.onNext(mailAddress)
                    target.inputs.inputRawPasswordTrigger.onNext(rawPassword)
                    target.inputs.executeSignupRequestTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.success))
                }
            }
            context("サーバーへの登録処理が失敗した場合") {
                let userName: String = "fumiyasac"
                let mailAddress: String = "fumiya.sakai@example.com"
                let rawPassword: String = "testcode1234"
                beforeEach {
                    testingDependency.injectIndividualMock(
                        mockInstance: signupUseCase,
                        protocolName: SignupUsecase.self
                    )
                    signupUseCase.given(
                        .execute(
                            userName: .value(userName),
                            mailAddress: .value(mailAddress),
                            rawPassword: .value(rawPassword),
                            willReturn: Single.error(CommonError.invalidResponse("送信された会員情報が不正です"))
                        )
                    )
                }
                afterEach {
                    testingDependency.removeIndividualMock(
                        protocolName: SignupUsecase.self
                    )
                }
                it("viewModel.outputs.requestStatusがAPIRequestState.errorとなること") {
                    let target = SignupViewModel()
                    target.inputs.inputUserNameTrigger.onNext(userName)
                    target.inputs.inputMailAddressTrigger.onNext(mailAddress)
                    target.inputs.inputRawPasswordTrigger.onNext(rawPassword)
                    target.inputs.executeSignupRequestTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.error))
                }
            }
        }

        // MARK: - undoAPIRequestStateTriggerを実行した際のテスト

        // MEMO: APIRequestStateを元に戻す場合
        describe("#undoAPIRequestStateTrigger") {
            context("APIリクエスト結果ダイアログ表示後に画面状態を元に戻す場合") {
                it("viewModel.outputs.requestStatusがAPIRequestState.noneとなること") {
                    let target = SignupViewModel()
                    target.inputs.undoAPIRequestStateTrigger.onNext(())
                    expect(try! target.outputs.requestStatus.toBlocking().first()).to(equal(APIRequestState.none))
                }
            }
        }
    }
}
