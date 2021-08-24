//
//  PriceResponse.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 24.08.2021.
//

import Foundation

struct PriceResponse: Codable {
    let currency: String
    let amount: Double
}
