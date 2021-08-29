//
//  InfoScreenView.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import UIKit
import RxSwift

class InfoScreenView: ViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    private let presenter: InfoScreenPresenter
    private let disposableBag = DisposeBag()
    var money: Money?
    
    init(presenter: InfoScreenPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        presenter.setupData()
    }
    
    func configUI() {
        tableView.register(
            UINib(nibName: "InfoScreenCell", bundle: nil),
            forCellReuseIdentifier: "InfoScreenCell"
        )
        tableView.dataSource = self
        
        let navItem = UINavigationItem(title: "")
        let refreshItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: nil, action: nil)
        let closeItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: nil, action: nil)
        navItem.rightBarButtonItem = refreshItem
        navItem.leftBarButtonItem = closeItem

        self.navigationBar.setItems([navItem], animated: false)
        navItem.rightBarButtonItem?.rx.tap.subscribe(onNext: { [weak self] in
            self?.presenter.setupData()
        }).disposed(by: disposableBag)
        navItem.leftBarButtonItem?.rx.tap.subscribe(onNext: { [weak self] in
            self?.presenter.openMainScreen()
        }).disposed(by: disposableBag)
    }
    
    func setData(_ money: Money?) {
        self.money = money
        tableView.reloadData()
    }
    
    func showLoading(_ show: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = show == true ? 0.6 : 1
            if show == true {
                self.activityInd.startAnimating()
            } else {
                self.activityInd.stopAnimating()
            }
        }
    }

}
