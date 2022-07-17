//
//  RequestSigninRepositorySpec.swift
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

final class RequestSigninRepositorySpec: QuickSpec {

    // MARK: - Override

    override func spec() {
        
        // MEMO: Testで動かす想定のDIコンテナのインスタンスを生成する
        let testingDependency = DependenciesDefinition()

        let apiRequestManager = APIRequestProtocolMock()
        let target = RequestSigninRepository()

        describe("RequestSigninRepository") {

            // MARK: - requestSigninを実行した際のテスト

            describe("#requestSignin") {

                // MEMO: API通信処理成功時の想定
                context("APIから正常にレスポンスが返却される場合") {
                    let mailAddress: String = "fumiya.sakai@example.com"
                    let rawPassword: String = "testcode1234"
                    let signinSuccessResponse = SigninSuccessResponse(
                        result: "OK",
                        token: "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJmdW1peWFzYWMiLCJleHAiOjE2NTgxMzAyMDB9.UQnRp8gM-qhWN8lfsYIEasluc7MjHjRYjwutLALSr8rzXxaAaaG6cJ7GmDK1ERg068KdAGRoih2-CQFy9B_ibA"
                    )

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        testingDependency.injectIndividualMock(
                            mockInstance: apiRequestManager,
                            protocolName: APIRequestProtocol.self
                        )
                        apiRequestManager.given(
                            .requestSiginin(
                                mailAddress: .value(mailAddress),
                                rawPassword: .value(rawPassword),
                                willReturn: Single.just(signinSuccessResponse)
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
                            try! target.requestSignin(
                                mailAddress: mailAddress,
                                rawPassword: rawPassword
                            ).toBlocking().first()
                        ).to(
                            equal(signinSuccessResponse)
                        )
                    }
                }
            }
        }
    }
}
