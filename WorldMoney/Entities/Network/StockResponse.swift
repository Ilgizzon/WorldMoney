//
//  StockResponse.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation

struct StockResponse: Codable {
    let name: String
    let price: PriceResponse
    let percentChange: Double
    let volume: Int
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case name, price
        case percentChange
        case volume, symbol
    }
}
