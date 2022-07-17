//
//  RealmAccessManager.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/21.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmAccessManager {

    // MARK: - Singleton Instance

    static let shared = RealmAccessManager()

    // MARK: - Properies

    private let schemaConfig = Realm.Configuration(schemaVersion: 0)

    // MARK: - Function

    // 引数で与えられた型に該当するRealmオブジェクトを全件取得する
    func getAllObjects<T: Object>(_ realmObjectType: T.Type) -> Results<T>? {
        let realm = try! Realm(configuration: schemaConfig)
        return realm.objects(T.self)
    }

    // 該当するRealmオブジェクトを追加する
    func save<T: Object>(_ realmObject: T) {
        let realm = try! Realm(configuration: schemaConfig)
        try! realm.write() {
            realm.add(realmObject)
        }
    }

    // 該当するRealmオブジェクトを削除する
    func delete<T: Object>(_ realmObject: T) {
        let realm = try! Realm(configuration: schemaConfig)
        try! realm.write() {
            realm.delete(realmObject)
        }
    }
}
