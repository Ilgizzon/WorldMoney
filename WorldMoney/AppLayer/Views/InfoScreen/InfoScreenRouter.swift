//
//  InfoScreenRouter.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import EasyDi
import UIKit

class InfoScreenRouter {
    
    weak var presenter: InfoScreenPresenter?
    private let navigationService: NavigationService
    
    init(navigationService: NavigationService) {
        self.navigationService = navigationService
    }
    
    class func createModule(symbol: String) -> InfoScreenView {
        InfoScreenAssembly.instance().symbol = symbol
        return InfoScreenAssembly.instance().view
    }
    
    func openMainScreen() {
        let view = MainScreenRouter.createModule()
        navigationService.setRoot(view)
    }
}
