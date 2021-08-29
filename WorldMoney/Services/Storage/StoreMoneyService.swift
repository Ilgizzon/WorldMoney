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
    
    func saveAll(money: MoneyRealm) -> MoneyRealm? {
        guard let date = lastAsOf else {
            try! storageCore.realm.write {
                storageCore.realm.add(money, update: .all)
            }
            lastAsOf = money.asOf
            return money
        }
       
        guard let newAsOf = money.asOf else {
            return nil
        }
        
        if date < newAsOf {
            try! storageCore.realm.write {
                storageCore.realm.add(money, update: .all)
            }
            lastAsOf = money.asOf
        }
        
        return money
    }
    
    func update(money: MoneyRealm) -> MoneyRealm? {
        guard let cacheMoneyAsOf = storageCore.realm.objects(MoneyRealm.self).first?.asOf else {
            try! storageCore.realm.write {
                storageCore.realm.add(money, update: .all)
            }
            lastAsOf = money.asOf
            return money
        }
        
        guard let newAsOf = money.asOf else {
            return nil
        }
        
        if cacheMoneyAsOf < newAsOf {
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
        
        return money
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
