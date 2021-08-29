//
//  Price.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation

class Price {
    let currency: String?
    let amount: Double?
    
    init(
        currency: String?,
        amount: Double?
    ) {
        self.currency = currency
        self.amount = amount
    }
}
