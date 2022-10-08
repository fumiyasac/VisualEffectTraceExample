//
//  DependenciesDefinition.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/16.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// PropertyWrapperを利用したDI処理に関する実装の解説については下記のブログにまとめています。
// 【実装MEMO】PropertyWrappersの機能を利用したDependency Injectionのコードに触れた際の備忘録
// https://bit.ly/2OLQwIu

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
                implInstance: RequestAnnouncementDataRepository(),
                protocolName: AnnouncementRepository.self
            ),
            (
                implInstance: RequestRecentAnnouncementRepository(),
                protocolName: RecentAnnouncementRepository.self
            ),
            (
                implInstance: RequestEventIntroductionDataRepository(),
                protocolName: EventIntroductionRepository.self
            ),
            (
                implInstance: RequestFeaturedArticleRepository(),
                protocolName: FeaturedArticleRepository.self
            ),
            (
                implInstance: RequestItemRepository(),
                protocolName: ItemRepository.self
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
                implInstance: RequestStoryRepository(),
                protocolName: StoryRepository.self
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

        // MEMO: ViewModel層の登録
        let viewModels: Array<(implInstance: Any, protocolName: Any)> = [
            (
                implInstance: MainViewModel(),
                protocolName: MainViewModelType.self
            ),
            (
                implInstance: AnnouncementViewModel(),
                protocolName: AnnouncementViewModelType.self
            ),
            (
                implInstance: TopBannerViewModel(),
                protocolName: TopBannerViewModelType.self
            ),
            (
                implInstance: EventIntroductionViewModel(),
                protocolName: EventIntroductionViewModelType.self
            ),
            (
                implInstance: FeaturedArticleViewModel(),
                protocolName: FeaturedArticleViewModelType.self
            ),
            (
                implInstance: ItemsViewModel(),
                protocolName: ItemsViewModelType.self
            ),
            (
                implInstance: SigninViewModel(),
                protocolName: SigninViewModelType.self
            ),
            (
                implInstance: SignupViewModel(),
                protocolName: SignupViewModelType.self
            ),
            (
                implInstance: StoryViewModel(),
                protocolName: StoryViewModelType.self
            ),
            (
                implInstance: TutorialViewModel(),
                protocolName: TutorialViewModelType.self
            )
        ]
        let _ = viewModels.map{ viewModel in
            container.register(
                viewModel.implInstance,
                for: Dependencies.Name(rawValue: TypeScanner.getName(viewModel.protocolName))
            )
        }
    }

    func injectIndividualMock(mockInstance: Any, protocolName: Any) {
        let container = Dependencies.Container.default
        container.register(
            mockInstance,
            for: Dependencies.Name(rawValue: TypeScanner.getName(protocolName))
        )
    }

    func removeIndividualMock(protocolName: Any) {
        let container = Dependencies.Container.default
        container.remove(for: Dependencies.Name(rawValue: TypeScanner.getName(protocolName)))
    }
}
