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
import PKHUD

final class SettingsViewController: UIViewController {

    // MARK: - SettingsFlow

    var coordinator: SettingsFlow?

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MARK: - @IBOutlet

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(TabBarItemsType.settings.getGlobalTabBarTitle())
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
