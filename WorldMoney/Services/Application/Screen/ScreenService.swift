//
//  ScreenService.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import Foundation
import UIKit

public class ScreenService {

    public var window: UIWindow

    init() {
        
        window = UIApplication.shared.windows.first ?? UIWindow(frame: UIScreen.main.bounds)
    }
}
