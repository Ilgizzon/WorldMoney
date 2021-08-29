//
//  MainScreenPresenter.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import Foundation
import RxSwift

class MainScreenPresenter {
    
    weak var view: MainScreenView?
    private let interactor: MainScreenInteractor
    private let router: MainScreenRouter
    private var disposableBag = DisposeBag()
    
    init(
        interactor: MainScreenInteractor,
        router: MainScreenRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func setupData() {
        view?.showLoading(true)
        interactor.getMoneys()
            .subscribe(onNext: { [weak self] money in
                self?.view?.setData(money)
                self?.view?.showLoading(false)
            }).disposed(by: disposableBag)
    }
    
    func openMoneyInfo(symbol: String?) {
        router.openMoneyInfo(symbol: symbol)
    }
}
