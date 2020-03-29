//
//  UIWindowScanner.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class UIWindowScanner {

    // MARK: - Static Function

    // 現在表示対象のUIWindowインスタンスを取得する
    static func getCurrentDisplayWindow() -> UIWindow? {

        // 現在表示されているUIWindowインスタンスを取得する（※iOS13以降とそれ以下では取得方法が異なる点に注意！）
        return  UIApplication.shared.connectedScenes
            .filter{ $0.activationState == .foregroundActive }
            .map{ $0 as? UIWindowScene }
            .compactMap{ $0 }
            .first?.windows
            .filter{ $0.isKeyWindow }
            .first
    }
}
