//
//  MainScreenInteractor.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import RxSwift

class MainScreenInteractor {
    private let moneyRepo: MoneyRepository
    
    init(moneyRepo: MoneyRepository) {
        self.moneyRepo = moneyRepo
    }
    
    func getMoneys() -> Observable<(Money?, offline:Bool)> {
        moneyRepo.getAllMoneys()
    }
}
