//
//  MainScreenView.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import UIKit
import RxSwift

class MainScreenView: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var money: Money?
    private var presenter: MainScreenPresenter
    
    init(presenter: MainScreenPresenter) {
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
            UINib(nibName: "MainScreenCell", bundle: nil),
            forCellReuseIdentifier: "MainScreenCell"
        )
        tableView.dataSource = self
    }
    
    func setData(_ money: Money?) {
        self.money = money
        tableView.reloadData()
    }
}
