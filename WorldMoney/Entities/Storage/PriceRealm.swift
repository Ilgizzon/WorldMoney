//
//  PriceRealm.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation
import RealmSwift

class PriceRealm: Object {
    @Persisted var currency: String
    @Persisted var amount: Double
}
