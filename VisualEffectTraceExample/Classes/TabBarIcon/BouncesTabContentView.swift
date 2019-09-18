//
//  BouncesTabContentView.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2019/09/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift

// MEMO: ライブラリ'ESTabBarController_swift'で利用可能な'ESTabBarItemContentView'を継承したクラス
// → バウンドするTabBarボタンを作成するために利用する。

final class BouncesTabContentView: ESTabBarItemContentView {

    public var duration = 0.36

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupBounceTabContentView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupBounceTabContentView()
    }
    
    // MARK: - Override

    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        executeTabBounceAnimation()
        completion?()
    }

    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        executeTabBounceAnimation()
        completion?()
    }
    
    // MARK: - Private Function

    private func setupBounceTabContentView() {

        // MEMO: 選択時・非選択時の配色を設定する
        textColor = UIColor.init(code: "#cccccc")
        iconColor = UIColor.init(code: "#cccccc")
        highlightTextColor = UIColor.init(code: "#ffae00")
        highlightIconColor = UIColor.init(code: "#ffae00")
    }

    // CoreAnimationを利用してアイコン表示部分のバウンドを利用する
    private func executeTabBounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.00 ,1.42, 0.87, 1.19, 0.96, 1.06, 1.00]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}
