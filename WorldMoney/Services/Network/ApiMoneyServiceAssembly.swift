//
//  ApiMoneyServiceAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import EasyDi

public class ApiMoneyServiceAssembly: Assembly {

    public var apiMoneyService: ApiMoneyService {
        
        return define(
            scope: .lazySingleton,
            init: ApiMoneyService(
                networkCore: self.networkCoreAssembly.networkCore
            )
        ) { $0 }
    }
    
    private lazy var networkCoreAssembly: NetworkCoreAssembly = context.assembly()
}
