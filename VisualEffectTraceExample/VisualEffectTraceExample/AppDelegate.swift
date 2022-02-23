//
//  AppDelegate.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

#if DEBUG
import Gedatsu
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MEMO: AutoLayoutデバッギングライブラリ「Gedatsu」の有効化
        #if DEBUG
        Gedatsu.open()
        #endif

        // MEMO: Dependency Injection用の処理を初期化する
        let domainDependency = DependenciesDefinition()
        domainDependency.inject()

        // MEMO: iOS15以降で適用するUINavigationController/UITabBarControllerの見た目に関する設定を適用する
        setupNavigationBarAppearance()
        setupTabBarAppearance()

        return true
    }

    // MARK: - Private Function

    private func setupNavigationBarAppearance() {

        // iOS15以降ではUINavigationBarの配色指定方法が変化する点に注意する
        // https://shtnkgm.com/blog/2021-08-18-ios15.html

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()

            // MEMO: UINavigationBar内部におけるタイトル文字の装飾設定
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]

            // MEMO: UINavigationBar背景色の装飾設定
            navigationBarAppearance.backgroundColor = UIColor.systemYellow

            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }

    private func setupTabBarAppearance() {

        // iOS15以降でiOS14以前と同じUINavigationBarの配色指定方法が変化する点に注意する
        // https://shtnkgm.com/blog/2021-08-18-ios15.html

        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()

            // UITabBarItemの選択時と非選択時の文字色の装飾設定
            tabBarItemAppearance.normal.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.lightGray
                
            ]
            tabBarItemAppearance.selected.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor(code: "#cda966")
            ]
            tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

