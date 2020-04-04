//
//  AppReducer.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

// Stateの更新が行われた際にappReduceを実行してStore内のStateを更新する ※Store内では全てのStateを一元管理している
func appReducer(action: Action, state: AppState?) -> AppState {

    var state = state ?? AppState()

    // 各々のActionを実行して変更されたReducerを反映する
    state.baseScreenState = BaseScreenReducer.reducer(action: action, state: state.baseScreenState)

    // Debug.
    AppLogger.printMessageForDebug("appReducerが実行されました。")

    return state
}
