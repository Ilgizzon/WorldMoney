//
//  StoreMoneyService.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//
import Foundation
import RxSwift
import RealmSwift

public class StoreMoneyService {
    
    private let storageCore: StorageCore
    private var lastAsOf: Date?
    
    public init(storageCore: StorageCore) {
        self.storageCore = storageCore
        getAsOf()
    }
    
    func saveAll(money: MoneyRealm) -> MoneyRealm {
        guard let date = lastAsOf else {
            storageCore.realm.add(money, update: .all)
            lastAsOf = money.asOf
            return money.freeze()
        }
       
        if date < money.asOf {
            storageCore.realm.add(money, update: .all)
            lastAsOf = money.asOf
        }
        
        return money.freeze()
    }
    
    func update(money: MoneyRealm) -> MoneyRealm? {
        guard let cacheMoney = storageCore.realm.objects(MoneyRealm.self).first else {
            storageCore.realm.add(money, update: .all)
            lastAsOf = money.asOf
            return money.freeze()
        }
        
        if cacheMoney.asOf < money.asOf {
            let symbols = money.stock.map { $0.symbol }
            guard let stocksForUpdate = storageCore.realm.objects(MoneyRealm.self)
                .first?.stock
                .filter("symbol IN %@", symbols)
            else {
                return nil
            }
            
            for stock in stocksForUpdate {
                
                guard let newStock = money.stock.filter({$0.symbol == stock.symbol}).first else {
                    continue
                }
                
                try! storageCore.realm.write {
                    stock.name = newStock.name
                    stock.price = newStock.price
                    stock.percentChange = newStock.percentChange
                    stock.volume = newStock.volume
                }
            }
        }
        
        return money.freeze()
    }
    
    func getAll() -> MoneyRealm? {
        let cacheMoney = storageCore.realm.objects(MoneyRealm.self).first
        return cacheMoney
    }
    
    func getCurrent(symbol: String) -> MoneyRealm? {
        let cacheMoney = storageCore.realm.objects(MoneyRealm.self)
            .filter("stock.@symbol IN %@", symbol).first
        
        return cacheMoney
    }
    
    private func getAsOf() {
        lastAsOf = storageCore.realm.objects(MoneyRealm.self).first?.asOf
    }
}
