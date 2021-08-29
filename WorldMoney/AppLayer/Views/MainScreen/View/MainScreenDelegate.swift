//
//  MainScreenDelegate.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import Foundation
extension MainScreenView: MainScreenCellDelegate {
    func onTapCell(_ symbol: String?) {
        presenter.openMoneyInfo(symbol: symbol)
    }
    
    
}

