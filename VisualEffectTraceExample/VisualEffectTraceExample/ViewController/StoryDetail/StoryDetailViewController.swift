//
//  StoryDetailViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/06/14.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class StoryDetailViewController: UIViewController {

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - StoryboardInstantiatable

extension StoryDetailViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "StoryDetail"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
