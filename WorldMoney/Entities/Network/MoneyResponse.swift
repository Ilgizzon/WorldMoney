//
//  MoneyResponse.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation

struct MoneyResponse: Codable {
    let stock: [StockResponse]
    let asOf: Date

    enum CodingKeys: String, CodingKey {
        case stock
        case asOf
    }
}
