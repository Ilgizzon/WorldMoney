//
//  NetworkCoreAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 22.08.2021.
//

import EasyDi
import Alamofire

public class NetworkCoreAssembly: Assembly {

    public var networkCore: NetworkCore {
        let networkConfig = self.configServicesAssembly.configServices.getNetworkConfig()
        return define(
            scope: .lazySingleton,
            init: NetworkCore(
                apiBase: networkConfig.baseUrl,
                session: Session()
            )
        ) { $0 }
    }
    
    private lazy var configServicesAssembly: ConfigServicesAssembly = context.assembly()
}
