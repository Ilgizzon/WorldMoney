//
//  InfoScreenAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import EasyDi


class InfoScreenAssembly: Assembly {


    var symbol = ""
    var view: InfoScreenView {
        define(init: InfoScreenView(
            presenter: self.presenter
        )) {
            self.presenter.view = $0
            return $0
        }
    }
    
    private var router: InfoScreenRouter {
        define(init: InfoScreenRouter(
                navigationService: self.navigationServiceAssembly.service
        )) { $0 }
    }
    
    private var presenter: InfoScreenPresenter {
        define(init: InfoScreenPresenter(
            interactor: self.interactor,
            router: self.router
        )) {
            self.router.presenter = $0
            return $0
        }
    }
    
    private var interactor: InfoScreenInteractor {
        define(init: InfoScreenInteractor(
            moneyRepo: self.moneyRepositoryAssembly.moneyRepository,
            symbol: self.symbol
        )) { $0 }
    }
    
    private lazy var moneyRepositoryAssembly: MoneyRepositoryAssembly = context.assembly()
    private lazy var navigationServiceAssembly: NavigationServiceAssembly = context.assembly()
}
