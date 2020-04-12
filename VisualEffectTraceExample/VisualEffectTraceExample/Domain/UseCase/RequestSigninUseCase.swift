//
//  RequestSigninUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/11.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol SigninUsecase {

    // サインイン処理を実行する
    func execute(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse>
}

final class RequestSigninUseCase: SigninUsecase {

    private let signinRepository: SigninRepository

    // MARK: - Initializer

    init(signinRepository: SigninRepository) {
        self.signinRepository = signinRepository
    }

    // MARK: - SigninUsecase

    func execute(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse> {
        return signinRepository.requestSignin(mailAddress: mailAddress, rawPassword: rawPassword)
    }
}
