//
//  AppLogger.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

struct AppLogger {

    // MARK: - Static Function

    // 変更されたStateをconsoleへ出力する
    static func printStateForDebug(_ targetState: ReSwift.StateType, viewController: UIViewController) {

        let viewControllerName = String(describing: type(of: viewController))
        print("---")
        print("実行時刻:", Date())
        print("State Logging #start:", viewControllerName)
        print(targetState)
        print("State Logging #end:")
        print("---\n\n")
    }

    // 実行されたActionCreatorをconsoleへ出力する
    static func printExecuteActionForDebug(_ targetAction: ReSwift.Action) {

        print("---")
        print("実行時刻:", Date())
        print("ActionCreator logging #start:")
        print(targetAction)
        print("ActionCreator logging #end:")
        print("---\n\n")
    }

    // メッセージをconsoleへ出力する
    static func printMessageForDebug(_ message: String) {

        print("---")
        print("実行時刻:", Date())
        print(message)
        print("---\n\n")
    }
}
