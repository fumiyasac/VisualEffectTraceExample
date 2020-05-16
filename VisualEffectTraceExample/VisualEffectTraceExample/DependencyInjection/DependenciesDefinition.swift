//
//  DependenciesDefinition.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/16.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

final class DependenciesDefinition {

    // MARK: - Function

    // MEMO: PropertyWrapperを利用したDependencyInjectionを実施する
    func inject() {

        let container = Dependencies.Container.default

        // MEMO: 命名で厳密に縛りたい場合は第2引数にこのような名前をつけてあげる
        // DI実行側 → container.register(RealmAccessManager.shared, Dependencies.Name(rawValue: "RealmAccessProtocol"))
        // DI定義側 → @Dependencies.Inject(Dependencies.Name(rawValue: "RealmAccessProtocol")) private var realmAccessManager: RealmAccessProtocol
        // ※ Dependencies.Nameの対応を正しく定義していないとクラッシュが発生するような形にしている

        // MEMO: Infrastructure層の登録
        let managers: Array<(implInstance: Any, protocolName: Any)> = [
            (
                implInstance: APIRequestManager.shared,
                protocolName: APIRequestProtocol.self
            ),
            (
                implInstance: RealmAccessManager.shared,
                protocolName: RealmAccessProtocol.self
            ),
            (
                implInstance: KeychainAccessManager.shared,
                protocolName: KeychainAccessProtocol.self
            )
        ]
        let _ = managers.map{ manager in
            container.register(
                manager.implInstance,
                for: Dependencies.Name(rawValue: TypeScanner.getName(manager.protocolName))
            )
        }

        // MEMO: Repository層の登録
        let repositories: Array<(implInstance: Any, protocolName: Any)> = [
            (
                implInstance: CurrentApplicationUserRepository(),
                protocolName: ApplicationUserRepository.self
            ),
            (
                implInstance: MainScreenRepository(),
                protocolName: MainRepository.self
            ),
            (
                implInstance: RequestAnnoucementDataRepository(),
                protocolName: AnnoucementRepository.self
            ),
            (
                implInstance: RequestEventIntroductionDataRepository(),
                protocolName: EventIntroductionRepository.self
            ),
            (
                implInstance: RequestSigninRepository(),
                protocolName: SigninRepository.self
            ),
            (
                implInstance: RequestSignupRepository(),
                protocolName: SignupRepository.self
            ),
            (
                implInstance: RequestTopBannerDataRepository(),
                protocolName: TopBannerRepository.self
            ),
            (
                implInstance: TutorialDataRepository(),
                protocolName: TutorialRepository.self
            )
        ]
        let _ = repositories.map{ repository in
            container.register(
                repository.implInstance,
                for: Dependencies.Name(rawValue: TypeScanner.getName(repository.protocolName))
            )
        }

        // MEMO: UseCase層の登録
        let useCases: Array<(implInstance: Any, protocolName: Any)>  = [
            (
                implInstance: GetTutorialDataUseCase(),
                protocolName: TutorialUseCase.self
            ),
            (
                implInstance: HandleMainScreenUseCase(),
                protocolName: MainScreenUseCase.self
            ),
            (
                implInstance: RequestAnnouncementDataUseCase(),
                protocolName: AnnouncementUsecase.self
            ),
            (
                implInstance: RequestEventIntroductionDataUseCase(),
                protocolName: EventIntroductionUseCase.self
            ),
            (
                implInstance: RequestSigninUseCase(),
                protocolName: SigninUsecase.self
            ),
            (
                implInstance: RequestSignupUseCase(),
                protocolName: SignupUsecase.self
            ),
            (
                implInstance: RequestTopBannerDataUseCase(),
                protocolName: TopBannerUseCase.self
            ),
            (
                implInstance: UpdateCurrentApplicationUserStatusUseCase(),
                protocolName: ApplicationUserStatusUseCase.self
            )
        ]
        let _ = useCases.map{ useCase in
            container.register(
                useCase.implInstance,
                for: Dependencies.Name(rawValue: TypeScanner.getName(useCase.protocolName))
            )
        }
    }
}
