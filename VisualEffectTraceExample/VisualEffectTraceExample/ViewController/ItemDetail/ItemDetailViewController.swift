//
//  ItemDetailViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/16.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class ItemDetailViewController: UIViewController {

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - StoryboardInstantiatable

extension ItemDetailViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "ItemDetail"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
