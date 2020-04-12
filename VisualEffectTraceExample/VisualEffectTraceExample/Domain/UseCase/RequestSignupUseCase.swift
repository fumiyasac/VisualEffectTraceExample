//
//  RequestSignupUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol SignupUsecase {

    // サインアップ処理を実行する
    func execute(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse>
}

final class RequestSignupUseCase: SignupUsecase {

    private let signupRepository: SignupRepository

    // MARK: - Initializer

    init(signupRepository: SignupRepository) {
        self.signupRepository = signupRepository
    }

    // MARK: - SignupUsecase

    func execute(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse> {
        return signupRepository.requestSignup(userName: userName, mailAddress: mailAddress, rawPassword: rawPassword)
    }
}
