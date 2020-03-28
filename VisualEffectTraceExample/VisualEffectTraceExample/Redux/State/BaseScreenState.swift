//
//  BaseScreenState.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

// アプリ起動からベース画面定義に関するstateの定義
struct BaseScreenState: ReSwift.StateType {

    // UIPageViewControllerのインデックス位置（初期値: nil）
    var applicationUserStatus: ApplicationUserStatus? = nil
}
