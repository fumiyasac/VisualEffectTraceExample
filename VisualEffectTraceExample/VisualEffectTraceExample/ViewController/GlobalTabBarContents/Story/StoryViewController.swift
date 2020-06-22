//
//  StoryViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

// UICollectionViewCompositionalLayoutでは実現できない表現の例（3）
// 水平方向と垂直方向が合わさった形のUICollectionViewの表現（タイムテーブルやフォトギャラリー等でも類似した形のものがある）
// 参考:
// https://xyk.hatenablog.com/entry/2017/02/09/184410
// https://www.indetail.co.jp/blog/5257/

final class StoryViewController: UIViewController {

    // MARK: - StoryFlow

    var coordinator: StoryFlow?

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(TabBarItemsType.story.getGlobalTabBarTitle())
    }
}

// MARK: - StoryboardInstantiatable

extension StoryViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Story"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
