//
//  RealmProvider.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 31.03.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import RealmSwift

class RealmProvider {
    class func realm() -> Realm {
        if let _ = NSClassFromString("XCTest") {
            return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "test", encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, objectTypes: nil))
        } else {
            return try! Realm();
        }
    }
}
