//
//  GlobalTabBarController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/22.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class GlobalTabBarController: UITabBarController {

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - StoryboardInstantiatable

extension GlobalTabBarController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "GlobalTabBar"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
