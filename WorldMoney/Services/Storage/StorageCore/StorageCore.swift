//
//  StorageCore.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 22.08.2021.
//

import Foundation
import RealmSwift

public class StorageCore {
    
    public let realm: Realm
    
    public init(config: Realm.Configuration) {
        self.realm = try! Realm(configuration: config)
    }
}
