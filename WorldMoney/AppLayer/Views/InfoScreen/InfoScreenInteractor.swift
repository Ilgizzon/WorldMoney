//
//  InfoScreenInteractor.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import RxSwift

class InfoScreenInteractor {
    private let moneyRepo: MoneyRepository
    private var symbol: String
    
    init(
        moneyRepo: MoneyRepository,
        symbol: String
    ) {
        self.moneyRepo = moneyRepo
        self.symbol = symbol
    }
    
    func getMoney() -> Observable<Money?> {
        moneyRepo.getCurrentMoney(symbol)
    }
}
