//
//  AppState.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

// アプリの画面状態管理に関するState
struct AppState: ReSwift.StateType {

    // チュートリアルに関する画面に関するstate
    var baseScreenState = BaseScreenState()
}
