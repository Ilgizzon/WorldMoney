//
//  Money.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation

class Money {
    let stock: [Stock]
    let asOf: Date?
    
    init(
        stock: [Stock],
        asOf: Date?
    ) {
        self.stock = stock
        self.asOf = asOf
    }
}
