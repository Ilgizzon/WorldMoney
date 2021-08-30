//
//  ApiMoneyService.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import Foundation
import RxSwift

public class ApiMoneyService {
    
    private let networkCore: NetworkCore
    private let apiUrls = ConfigServices().getNetworkConfig()
    
    public init(networkCore: NetworkCore) {
        self.networkCore = networkCore
    }
    
    func getAllMoneys() -> Observable<MoneyResponse> {
        return networkCore.request(
            method: .get,
            path: apiUrls.allСurrenciesUrl
        ).mapToObject()
    }
    
    func getCurrentMoney(symbol: String) -> Observable<MoneyResponse> {
        let fullUrl = String(format: apiUrls.currentСurrencyUrl, symbol)
        return networkCore.request(
            method: .get,
            path: fullUrl
        ).mapToObject()
    }
    
}
