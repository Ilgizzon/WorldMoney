//
//  MoneyRepositoryAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import EasyDi

public class MoneyRepositoryAssembly: Assembly {

    public var moneyRepository: MoneyRepository {
        
        return define(
            scope: .lazySingleton,
            init: MoneyRepository(
                apiMoneyService: self.apiMoneyServiceAssembly.apiMoneyService,
                storeMoneyService: self.storeMoneyServiceAssembly.storeMoneyService
            )
        ) { $0 }
    }
    
    private lazy var storeMoneyServiceAssembly: StoreMoneyServiceAssembly = context.assembly()
    private lazy var apiMoneyServiceAssembly: ApiMoneyServiceAssembly = context.assembly()
}
