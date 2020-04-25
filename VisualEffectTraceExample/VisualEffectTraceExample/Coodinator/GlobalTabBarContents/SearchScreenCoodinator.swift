//
//  SearchScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol SearchFlow: class {

    // 検索一覧画面から詳細画面を表示する
    func coordinateToItemDetail()
}

class SearchScreenCoodinator: ScreenCoordinator, SearchFlow {

    // MARK: - Properties

    private let navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {

        // MEMO: GlobalTabBarに接続する画面については、UINavigationControllerでラップしているのでこの形にしています。
        self.navigationController = navigationController
    }

    // MARK: - ScreenCoordinator

    func start() {

        // 検索表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let searchViewController = SearchViewController.instantiate()
        searchViewController.coordinator = self

        // 検索画面の表示を実行する
        navigationController.pushViewController(searchViewController, animated: false)
    }

    // MARK: - ItemsFlow

    func coordinateToItemDetail() {
        print("アイテム詳細画面へ遷移する")
    }
}
