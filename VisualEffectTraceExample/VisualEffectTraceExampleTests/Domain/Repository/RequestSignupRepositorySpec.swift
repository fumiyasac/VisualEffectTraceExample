//
//  RequestSignupRepositorySpec.swift
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

final class RequestSignupRepositorySpec: QuickSpec {

    // MARK: - Override

    override func spec() {
        
        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let apiRequestManager = APIRequestProtocolMock()
        let target = RequestSignupRepository()

        describe("RequestSignupRepository") {

            // MARK: - requestSignupを実行した際のテスト

            describe("#requestSignup") {

                // MEMO: API通信処理成功時の想定
                context("APIから正常にレスポンスが返却される場合") {
                    let userName: String = "fumiyasac"
                    let mailAddress: String = "fumiya.sakai@example.com"
                    let rawPassword: String = "testcode1234"
                    let generalPostSuccessARIResponse = GeneralPostSuccessARIResponse(result: "OK")

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: apiRequestManager,
                            protocolName: APIRequestProtocol.self
                        )
                        apiRequestManager.given(
                            .requestSiginup(
                                userName: .value(userName),
                                mailAddress: .value(mailAddress),
                                rawPassword: .value(rawPassword),
                                willReturn: Single.just(generalPostSuccessARIResponse)
                            )
                        )
                    }
                    afterEach {
                        testingDependency.removeIndividualMock(
                            protocolName: APIRequestProtocol.self
                        )
                    }
                    it("正常なレスポンスを返却すること") {
                        expect(
                            try! target.requestSignup(
                                userName: userName,
                                mailAddress: mailAddress,
                                rawPassword: rawPassword
                            ).toBlocking().first()
                        ).to(
                            equal(generalPostSuccessARIResponse)
                        )
                    }
                }
            }
        }
    }
}
