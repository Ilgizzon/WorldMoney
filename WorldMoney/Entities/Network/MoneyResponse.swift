//
//  MoneyResponse.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation

struct MoneyResponse: Codable {
    let stock: [StockResponse]
    let asOf: Date?

    enum CodingKeys: String, CodingKey {
        case stock
        case asOf
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        stock = try values.decode([StockResponse].self, forKey: .stock)
        let asOfString = try values.decode(String.self, forKey: .asOf)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime
        ]
        asOf = formatter.date(from: asOfString)
    }
}
