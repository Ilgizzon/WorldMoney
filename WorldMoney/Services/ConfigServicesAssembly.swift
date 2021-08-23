//
//  ConfigServicesAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 22.08.2021.
//

import EasyDi

class ConfigServicesAssembly: Assembly {

    var configServices: ConfigServices {
        define(
            scope: .lazySingleton,
            init: ConfigServices()
        ) { $0 }
    }

}
