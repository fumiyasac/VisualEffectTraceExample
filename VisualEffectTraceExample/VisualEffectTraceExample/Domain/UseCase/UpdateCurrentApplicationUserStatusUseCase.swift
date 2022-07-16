//
//  UpdateCurrentApplicationUserStatusUsecase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

//sourcery: AutoMockable
protocol ApplicationUserStatusUseCase {

    // ユーザーのチュートリアル完了フラグを更新する
    func executeUpdatePassTutorialStatus() -> Completable

    // ユーザーがサインイン時に受け取ったJsonAccessTokenをキーチェーンへ格納する
    func executeUpdateToken(_ token: String)
}

final class UpdateCurrentApplicationUserStatusUseCase: ApplicationUserStatusUseCase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "ApplicationUserRepository")) private var applicationUserRepository: ApplicationUserRepository

    // MARK: - ApplicationUserStatusUsecase

    func executeUpdatePassTutorialStatus() -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(CommonError.notExistSelf))
                return Disposables.create()
            }
            self.applicationUserRepository.updatePassTutorialStatus()
            completable(.completed)
            return Disposables.create()
        }
    }

    func executeUpdateToken(_ token: String) {
        applicationUserRepository.updateJsonAccessToken(token)
    }
}
