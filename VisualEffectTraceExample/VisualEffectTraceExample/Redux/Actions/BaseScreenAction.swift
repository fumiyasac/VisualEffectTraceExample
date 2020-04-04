//
//  BaseScreenAction.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

extension BaseScreenState {

    // アプリ起動からベース画面定義に関するstateを変更させるアクションをEnumで定義する
    enum BaseScreenAction: ReSwift.Action {

        // 現在アプリ内に格納されている情報から起動後に表示する画面先を決めるためのアクション
        case setApplicationUserStatus(targetStatus: ApplicationUserStatus)
    }
}
