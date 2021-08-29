//
//  MainScreenAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import EasyDi


class MainScreenAssembly: Assembly {


    
    var view: MainScreenView {
        define(init: MainScreenView(
            presenter: self.presenter
        )) {
            self.presenter.view = $0
            return $0
        }
    }
    
    private var router: MainScreenRouter {
        define(init: MainScreenRouter()) { $0 }
    }
    
    private var presenter: MainScreenPresenter {
        define(init: MainScreenPresenter(
            moneyRepo: self.moneyRepositoryAssembly.moneyRepository
        )) { $0 }
    }
    
    private lazy var moneyRepositoryAssembly: MoneyRepositoryAssembly = context.assembly()
}
