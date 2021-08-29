//
//  ViewController.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var topOffset: NSLayoutConstraint?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        let nibName = String(describing: Swift.type(of: self))
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            super.init(nibName: nibName, bundle: Bundle.main)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let offset = topOffset else {
            return
        }
        let point = CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.size.height)
        guard let y = view?.convert(point, from: UIApplication.shared.keyWindow).y else {
            return
        }
        
        offset.constant = y
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
