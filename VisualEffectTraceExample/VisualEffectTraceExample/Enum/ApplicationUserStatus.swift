//
//  ApplicationUserStatus.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: チュートリアル画面・ログイン画面・コンテンツ用TabBar画面への遷移コントロールするための識別用
enum ApplicationUserStatus {

    // チュートリアル画面へ遷移する
    case needToMoveTutorialScreen
    // ログイン画面(会員登録画面)へ遷移する
    case needToMoveLoginScreen
    // コンテンツ用TabBar画面へ遷移する
    case needToMoveGlobalTabBarScreen
}
