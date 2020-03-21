//
//  RealmAccessManager.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/21.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RealmSwift

// ※ Mockに置き換えられるような形にしておくのがポイント

protocol RealmAccessProtocol {

    // 引数で与えられた型に該当するRealmオブジェクトを全件取得する
    func getAllObjects<T: Object>(_ realmObject: T) -> Results<T>?

    // 該当するRealmオブジェクトを追加する
    func save<T: Object>(_ realmObject: T)

    // 該当するRealmオブジェクトを削除する
    func delete<T: Object>(_ realmObject: T)
}

class RealmAccessManager: RealmAccessProtocol {

    private let schemaConfig = Realm.Configuration(schemaVersion: 0)

    // MARK: - Function

    func getAllObjects<T: Object>(_ realmObject: T) -> Results<T>? {
        let realm = try! Realm(configuration: schemaConfig)
        return realm.objects(T.self)
    }

    func save<T: Object>(_ realmObject: T) {
        let realm = try! Realm(configuration: schemaConfig)
        try! realm.write() {
            realm.add(realmObject)
        }
    }

    func delete<T: Object>(_ realmObject: T) {
        let realm = try! Realm(configuration: schemaConfig)
        try! realm.write() {
            realm.delete(realmObject)
        }
    }
}

