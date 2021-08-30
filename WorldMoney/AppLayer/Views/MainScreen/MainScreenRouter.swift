//
//  MainScreenRouter.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import EasyDi
import UIKit

class MainScreenRouter {
    
    weak var presenter: MainScreenPresenter?
    private let navigationService: NavigationService
    
    init(navigationService: NavigationService) {
        self.navigationService = navigationService
    }
    
    class func createModule() -> MainScreenView {
        return MainScreenAssembly.instance().view
    }
    
    func openMoneyInfo(symbol: String?) {
        guard let symbol = symbol else {
            return
        }
        let view = InfoScreenRouter.createModule(symbol: symbol)
        navigationService.present(view)
    }
}
