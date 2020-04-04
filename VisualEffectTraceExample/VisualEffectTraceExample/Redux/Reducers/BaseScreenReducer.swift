//
//  BaseScreenReducer.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

struct BaseScreenReducer {}

extension BaseScreenReducer {

    // MARK: - Static Function

    static func reducer(action: ReSwift.Action, state: BaseScreenState?) -> BaseScreenState {

        var state = state ?? BaseScreenState()

        // MEMO: ユーザーの画面遷移を決定するためのアクションでない場合はStateの変更は許容しない
        guard let action = action as? BaseScreenState.BaseScreenAction else { return state }

        switch action {
        
        case let .setApplicationUserStatus(targetStatus):
            state.applicationUserStatus = targetStatus
        }

        // Debug.
        AppLogger.printMessageForDebug("BaseScreenStateが更新されました。")

        return state
    }
}
