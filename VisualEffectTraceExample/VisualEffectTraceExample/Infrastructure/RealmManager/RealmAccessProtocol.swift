//
//  RealmAccessProtocol.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2022/07/17.
//  Copyright © 2022 酒井文也. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol RealmAccessProtocol {

    // ApplicationUserEntityオブジェクトを取得する
    func getApplicationUser() -> ApplicationUserEntity?

    // 新規にApplicationUserEntityオブジェクトを追加する
    func saveApplicationUser(_ applicationUserEntity: ApplicationUserEntity)

    // 既存のApplicationUserEntityオブジェクトを削除する
    func deleteApplicationUser(_ applicationUserEntity: ApplicationUserEntity)
}
