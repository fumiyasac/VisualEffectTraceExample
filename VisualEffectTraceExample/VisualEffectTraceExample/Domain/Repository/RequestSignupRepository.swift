//
//  RequestSignupRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/13.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

//sourcery: AutoMockable
protocol SignupRepository {

    // サインアップ処理用のAPIリクエストを実行する
    func requestSignup(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse>
}

final class RequestSignupRepository: SignupRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - SigninRepository

    func requestSignup(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse> {
        return apiRequestManager.requestSiginup(userName: userName, mailAddress: mailAddress, rawPassword: rawPassword)
    }
}
