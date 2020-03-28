//
//  ActionLoggingMiddleware.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import ReSwift

// どのアクションが発火したかを表示するためのMiddleware
let ActionLoggingMiddleware: Middleware<Any> = { dispatch, getState in
    return { next in
        return { action in

            // 実行されたActionCreatorの出力
            AppLogger.printExecuteActionForDebug(action)

            // 該当するReducerへの処理を実行する
            return next(action)
        }
    }
}
