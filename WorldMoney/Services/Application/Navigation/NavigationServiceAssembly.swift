//
//  NavigationServiceAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import EasyDi

public class NavigationServiceAssembly: Assembly {
    public var service: NavigationService {
        define(
            scope: .lazySingleton,
            init: NavigationService(
                screenService: self.screenServiceAssembly.service
        )) { $0 }
    }
    private lazy var screenServiceAssembly: ScreenServiceAssembly = context.assembly()
}
