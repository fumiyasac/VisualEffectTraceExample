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

    // MARK: - BlockSubscriber

    private lazy var baseScreenSubscriber: BlockSubscriber<BaseScreenState> = BlockSubscriber { [weak self] state in
        guard let self = self else { return }

        // MEMO: Reduxの処理で反映されたStateの値を経由して画面遷移処理を実施する
        guard let targetApplicationUserStatus = state.applicationUserStatus else {
            return
        }
        self.displayScreenBy(targetApplicationUserStatus)
    }

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        // ViewModelのOutputで定義した変数の値が反映された際に実行する処理
        viewModel.outputs.targetApplicationUserState
            .subscribe(
                onNext: { applicationUserStatus in

                    // MEMO: 画面遷移などをはじめとする画面状態の管理についてはReduxを経由してハンドリングする
                    BaseScreenActionCreator.setCurrentApplicationUserStatus(applicationUserStatus)
                }
            )
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // ViewModelのInputで定義したデータ取得処理に関するトリガーを発火する
        viewModel.inputs.initialSettingTrigger.onNext(())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 購読対象のStateをBlockSubscriberを利用して決定する
        appStore.subscribe(self.baseScreenSubscriber) { state in
            state.select { state in state.baseScreenState }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // 購読対象のStateを解除する
        appStore.unsubscribe(self.baseScreenSubscriber)
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
