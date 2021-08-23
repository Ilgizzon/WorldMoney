//
//  ConfigServices.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 22.08.2021.
//


public class ConfigServices {
    
     struct Network {
        let baseUrl = "http://phisix-api3.appspot.com"
        let allСurrenciesUrl = "/stocks.json"
        let currentСurrencyUrl = "/stocks/%@.json"
    }
    
    struct Storage {
        let schemaVersion: UInt64 = 1
        let deleteRealmIfMigrationNeeded = true
    }
    
    func getNetworkConfig() -> Network {
        Network()
    }
    
    func getStorageConfig() -> Storage {
        Storage()
    }
}
