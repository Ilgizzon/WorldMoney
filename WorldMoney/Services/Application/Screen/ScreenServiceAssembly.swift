//
//  ScreenServiceAssembly.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import EasyDi

public class ScreenServiceAssembly: Assembly {
    public var service: ScreenService {
        define(
            scope: .lazySingleton,
            init: ScreenService()
        ) { $0 }
    }
}
