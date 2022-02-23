//
//  MainViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift

// 各種画面への遷移を振り分けるためのViewController

final class MainViewController: UIViewController {

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MEMO: ユーザー状態に応じた画面表示を実施するためのViewModel
    @Dependencies.Inject(Dependencies.Name(rawValue: "MainViewModelType")) private var viewModel: MainViewModelType

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        // ViewModelのOutputで定義した変数の値が反映された際に実行する処理
        viewModel.outputs.targetApplicationUserState
            .subscribe(
                onNext: { [weak self] applicationUserStatus in
                    guard let self = self else { return }
                    self.displayScreenBy(applicationUserStatus)
                }
            )
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // ViewModelのInputで定義したデータ取得処理に関するトリガーを発火する
        viewModel.inputs.initialSettingTrigger.onNext(())
    }

    // MARK: - Private Function

    private func displayScreenBy(_ applicationUserState: ApplicationUserStatus) {

        // MEMO: 画面遷移処理をCoodinatorパターンで実施する形にする
        switch applicationUserState {

        // チュートリアル画面へ遷移する
        case .needToMoveTutorialScreen:
            let tutorialCoodinator = TutorialScreenCoordinator()
            tutorialCoodinator.start()

        // サインイン画面へ遷移する
        case .needToMoveSigninScreen:
            let signinCoodinator = SigninScreenCoordinator()
            signinCoodinator.start()

        // サインイン成功時のコンテンツ画面へ遷移する
        case .needToMoveGlobalTabBarScreen:
            let globalTabBarCoodinator = GlobalTabBarScreenCoodinator()
            globalTabBarCoodinator.start()
        }
    }
}
