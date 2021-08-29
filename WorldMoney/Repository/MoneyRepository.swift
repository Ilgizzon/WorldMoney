//
//  MoneyRepository.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import Foundation
import RxSwift
import RealmSwift

public class MoneyRepository {
    
    private let apiMoneyService: ApiMoneyService
    private let storeMoneyService: StoreMoneyService
    
    public init(
        apiMoneyService: ApiMoneyService,
        storeMoneyService: StoreMoneyService
    ) {
        self.apiMoneyService = apiMoneyService
        self.storeMoneyService = storeMoneyService
    }
    
    func getAllMoneys() -> Observable<Money?> {
        return apiMoneyService.getAllMoneys()
            .flatMap { moneysResponse -> Observable<Money?> in
                let saveStorage = self.storeMoneyService.saveAll(
                    money: self.convertNetworkToStorage(response: moneysResponse)
                )
                
                let money = self.convertStorageToApp(storageData: saveStorage)
                
                return Observable<Money?>.just(money)
                
            }
            .retry(when: {_ -> Observable<Money?> in
                return Observable<Money?>.empty()
            })
            .ifEmpty(default: findStorage())
    }
    
    func getCurrentMoney(_ symbol: String) -> Observable<Money?> {
        return apiMoneyService.getCurrentMoney(symbol: symbol)
            .flatMap { moneysResponse -> Observable<Money?> in
                let updateStorage = self.storeMoneyService.update(
                    money: self.convertNetworkToStorage(response: moneysResponse)
                )
                
                let money = self.convertStorageToApp(storageData: updateStorage)
                
                return Observable<Money?>.just(money)
            }
            .retry(when: {_ -> Observable<Money?> in
                return Observable<Money?>.empty()
            })
            .ifEmpty(default: findStorage(symbol))
    }
    
    private func convertNetworkToStorage(response: MoneyResponse) -> MoneyRealm {
        let stockList = List<StockRealm>()
        
        for stock in response.stock {
            let rlmPrice = PriceRealm()
            rlmPrice.amount = stock.price.amount
            rlmPrice.currency = stock.price.currency
            
            let rlmStock = StockRealm()
            rlmStock.name = stock.name
            rlmStock.percentChange = stock.percentChange
            rlmStock.price = rlmPrice
            rlmStock.volume = stock.volume
            rlmStock.symbol = stock.symbol
            
            stockList.append(rlmStock)
        }
        
        let rlmMoney = MoneyRealm()
        rlmMoney.asOf = response.asOf
        rlmMoney.stock = stockList
        
        return rlmMoney
    }
    
    private func convertStorageToApp(storageData: MoneyRealm?) -> Money? {
        guard let storageData = storageData else {
            return nil
        }
        var stockList: [Stock] = []
        
        for stock in storageData.stock {
            let price = Price(
                currency: stock.price?.currency,
                amount: stock.price?.amount
            )
            
            let stock = Stock(
                name: stock.name,
                price: price,
                percentChange: stock.percentChange,
                volume: stock.volume,
                symbol: stock.symbol
            )

            stockList.append(stock)
        }
        
        let money = Money(
            stock: stockList,
            asOf: storageData.asOf
        )
        
        return money
        
    }
    
    private func findStorage(_ symbol: String? = nil) -> Money? {
        
        var storage: MoneyRealm?
        if let strongSymbol = symbol {
            storage = storeMoneyService.getCurrent(symbol: strongSymbol)
        } else {
            storage = storeMoneyService.getAll()
        }
        
        let money = self.convertStorageToApp(storageData: storage)
        
        return money
        
    }
}
