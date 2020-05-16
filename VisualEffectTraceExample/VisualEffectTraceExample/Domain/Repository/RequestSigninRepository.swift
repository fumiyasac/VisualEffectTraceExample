//
//  RequestSigninRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/11.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol SigninRepository {

    // サインイン処理用のAPIリクエストを実行する
    func requestSignin(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse>
}

final class RequestSigninRepository: SigninRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "APIRequestProtocol")) private var apiRequestManager: APIRequestProtocol

    // MARK: - SigninRepository

    func requestSignin(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse> {
        return apiRequestManager.requestSiginin(mailAddress: mailAddress, rawPassword: rawPassword)
    }
}
