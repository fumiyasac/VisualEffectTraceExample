//
//  ApplicationUserEntity.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/21.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RealmSwift

class ApplicationUserEntity: Object {

    @objc dynamic var id = UUID().uuidString
    @objc dynamic var alreadySignup = false
    @objc dynamic var alreadyPassTutorial = false
    @objc dynamic var applicationFirstOpenedAt = Date()

    override static func primaryKey() -> String? {
        return "id"
    }
}
