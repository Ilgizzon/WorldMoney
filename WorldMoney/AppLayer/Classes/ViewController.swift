//
//  ViewController.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var topOffset: NSLayoutConstraint?
    private var offlineView: OfflineView = OfflineView(frame: .zero)
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
        let frame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        let point = CGPoint(x: 0, y: frame.size.height)
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let y = view?.convert(point, from: window).y else {
            return
        }
        
        offset.constant = y
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        let rect = CGRect(x: self.view.bounds.minX, y: self.view.bounds.minY, width: self.view.bounds.width, height: self.view.bounds.height/6)
        offlineView = OfflineView(frame: rect)
        self.view.addSubview(offlineView)
    }
    
    func showErrorView(date: Date?) {
        offlineView.showErrorView(date: date)
    }
    
    func hideErrorView() {
        offlineView.hideErrorView()
    }
}
