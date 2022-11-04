//
//  SettingsViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/06/16.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingsViewController: UIViewController {

    // MARK: - SettingsFlow

    var coordinator: SettingsFlow?

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    @Dependencies.Inject(Dependencies.Name(rawValue: "KeychainAccessProtocol")) private var keychainAccessManager: KeychainAccessProtocol

    // MARK: - @IBOutlet
    
    @IBOutlet private weak var signoutButton: UIButton!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(TabBarItemsType.settings.getGlobalTabBarTitle())
        bindToRxSwift()
    }

    private func bindToRxSwift() {
        signoutButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }

                    // MEMO: KaychainからTokenを削除して再びサインイン画面に引き渡す
                    // → 厳密にいえばこの処理もきちんとRepository/UseCaseを利用した方が良い
                    self.keychainAccessManager.deleteJsonAccessToken()
                    self.coordinator?.coordinateToSignin()

                    // MEMO: Dependency Injection用の処理を初期化する
                    if isTesting()  {
                        print("Build for Unit Testing Starting...")
                    } else {
                        print("Build for Debug/Production Starting...")
                        let productionDependency = DependenciesDefinition()
                        productionDependency.reset()
                        productionDependency.inject()
                    }
                }
            )
            .disposed(by: disposeBag)
    }
}

// MARK: - StoryboardInstantiatable

extension SettingsViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Settings"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
