//
//  DispatchQueueExtension.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/09.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

public extension DispatchQueue {

    // 実行処理の識別番号を保持する変数
    private static var _onceTracker: [String] = []

    // 任意の処理を一度だけ実行するためのクラスメソッド
    class func once(token: String, block: () -> Void) {

        // 排他処理用ロックの開始
        objc_sync_enter(self)

        // deferで途中で処理が中断
        defer {
            // 排他処理用ロックの解除
            objc_sync_exit(self)
        }

        // 第1引数で指定したトークンが存在したら以降の処理を実行しない
        if _onceTracker.contains(token) {
            return
        }

        // 第1引数で指定したトークンを内部変数へセットする
        _onceTracker.append(token)

        // 第2引数で排他処理用ロックをかけて実行する処理を書く
        block()
    }
}
