//
//  MoneyRealm.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation
import RealmSwift

class MoneyRealm: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var asOf: Date
    @Persisted var stock: List<StockRealm>
}
