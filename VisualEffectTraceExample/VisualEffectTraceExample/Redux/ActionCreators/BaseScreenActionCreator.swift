//
//  BaseScreenActionCreator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct BaseScreenActionCreator {}

extension BaseScreenActionCreator {

    // MARK: - Static Function

    // ユーザーの状態に応じた画面遷移を実行するためのアクションを発行する
    static func setCurrentApplicationUserStatus(_ targetApplicationUserStatus: ApplicationUserStatus) {
        let action = BaseScreenState.Action.setApplicationUserStatus(targetStatus: targetApplicationUserStatus)
        appStore.dispatch(action)
    }
}
