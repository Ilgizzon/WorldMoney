//
//  Stock.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation

class Stock {
    let name: String
    let price: Price
    let percentChange: Double
    let volume: Int
    let symbol: String

    init(
        name: String,
        price: Price,
        percentChange: Double,
        volume: Int,
        symbol: String
    ) {
        self.name = name
        self.price = price
        self.percentChange = percentChange
        self.volume = volume
        self.symbol = symbol
    }
}
