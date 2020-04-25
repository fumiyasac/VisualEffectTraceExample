//
//  ItemsScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol ItemsFlow: class {

    // アイテム一覧画面から詳細画面を表示する
    func coordinateToItemDetail()
}

class ItemsScreenCoodinator: ScreenCoordinator, ItemsFlow {

    // MARK: - Properties

    private let navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {

        // MEMO: GlobalTabBarに接続する画面については、UINavigationControllerでラップしているのでこの形にしています。
        self.navigationController = navigationController
    }

    // MARK: - ScreenCoordinator

    func start() {

        // アイテム表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let itemsViewController = ItemsViewController.instantiate()
        itemsViewController.coordinator = self

        // アイテム画面の表示を実行する
        navigationController.pushViewController(itemsViewController, animated: false)
    }

    // MARK: - ItemsFlow

    func coordinateToItemDetail() {
        print("アイテム詳細画面へ遷移する")
    }
}
