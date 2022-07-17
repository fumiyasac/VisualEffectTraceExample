//
//  RealmAccess.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2022/07/17.
//  Copyright © 2022 酒井文也. All rights reserved.
//

import Foundation

// MARK: - RealmAccessProtocol

extension RealmAccessManager: RealmAccessProtocol {

    func getApplicationUser() -> ApplicationUserEntity? {
        if let applicationUserEntity = getAllObjects(ApplicationUserEntity.self)?.first {
            return applicationUserEntity
        } else {
            return nil
        }
    }

    func saveApplicationUser(_ applicationUserEntity: ApplicationUserEntity) {
        save(applicationUserEntity)
    }

    func deleteApplicationUser(_ applicationUserEntity: ApplicationUserEntity) {
        delete(applicationUserEntity)
    }
}
