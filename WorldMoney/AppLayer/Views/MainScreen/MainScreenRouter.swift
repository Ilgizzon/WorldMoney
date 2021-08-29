//
//  MainScreenRouter.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import EasyDi
import UIKit

class MainScreenRouter {
    
    class func createModule() -> MainScreenView {
        return MainScreenAssembly.instance().view
    }
}
