//
//  StorageCoreAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 23.08.2021.
//
import EasyDi
import RealmSwift
public class StorageCoreAssembly: Assembly {

    public var storageCore: StorageCore {
        let storageConfig = self.configServicesAssembly.configServices.getStorageConfig()
        return define(
            scope: .lazySingleton,
            init: StorageCore(
                config: Realm.Configuration(
                    schemaVersion: storageConfig.schemaVersion,
                    deleteRealmIfMigrationNeeded: storageConfig.deleteRealmIfMigrationNeeded
                )
            )
        ) { $0 }
    }
    
    private lazy var configServicesAssembly: ConfigServicesAssembly = context.assembly()
}
