//
//  ContainerCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

// MEMO: InterfaceBuilder上で「Use SafeArea Layout Guides」のチェックを外しています。

final class ContainerCollectionViewCell: UICollectionViewCell {

    private weak var storedTargetViewController: UIViewController!

    // MARK: - Typealias

    typealias DisplayViewControllerInContainerViewInformation = (targetViewController: UIViewController, parentViewController: UIViewController)

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Function

    func setCell(_ info: DisplayViewControllerInContainerViewInformation) {

        storedTargetViewController = info.targetViewController

        // 表示対象のViewControllerを.contentViewへ追加する
        storedTargetViewController.view.frame = contentView.frame
        self.contentView.addSubview(storedTargetViewController.view)

        // 表示対象のViewControllerをparentViewControllerの子として登録する
        info.parentViewController.addChild(storedTargetViewController)
        storedTargetViewController.didMove(toParent: info.parentViewController)
    }
}
