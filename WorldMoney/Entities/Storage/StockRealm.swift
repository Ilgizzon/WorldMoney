//
//  StockRealm.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation
import RealmSwift

class StockRealm: Object {
    @Persisted var name: String
    @Persisted var price: PriceRealm
    @Persisted var percentChange: Double
    @Persisted var volume: Int
    @Persisted(indexed: true) var symbol: String
}
