//
//  StoreMoneyServiceAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import EasyDi

public class StoreMoneyServiceAssembly: Assembly {

    public var storeMoneyService: StoreMoneyService {
        
        return define(
            scope: .lazySingleton,
            init: StoreMoneyService(
                storageCore: self.storageCoreAssembly.storageCore
            )
        ) { $0 }
    }
    
    private lazy var storageCoreAssembly: StorageCoreAssembly = context.assembly()
}
