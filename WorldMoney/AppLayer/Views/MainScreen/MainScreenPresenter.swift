//
//  MainScreenPresenter.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import Foundation
import RxSwift

class MainScreenPresenter {
    
    weak var view: MainScreenView?
    private let moneyRepo: MoneyRepository
    private var disposableBag = DisposeBag()
    
    init(moneyRepo: MoneyRepository) {
        self.moneyRepo = moneyRepo
    }
    
    func setupData() {
        moneyRepo.getAllMoneys()
            .subscribe(onNext: { [weak self] money in
                self?.view?.setData(money)
            }).disposed(by: disposableBag)
        
    }
}
