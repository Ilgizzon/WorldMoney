//
//  MainScreenPresenter.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import Foundation
import RxSwift

class MainScreenPresenter {
    
    enum RequestState {
        case done, inProgress
    }
    
    weak var view: MainScreenView?
    private let interactor: MainScreenInteractor
    private let router: MainScreenRouter
    private var disposableBag = DisposeBag()
    private var requestState: RequestState = .done
    
    init(
        interactor: MainScreenInteractor,
        router: MainScreenRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func setupData() {
        guard requestState == .done else {
            return
        }
        requestState = .inProgress
        view?.showLoading(true)
        interactor.getMoneys()
            .subscribe(onNext: { [weak self] money in
                self?.view?.setData(money)
                self?.view?.showLoading(false)
                self?.requestState = .done
            }).disposed(by: disposableBag)
    }
    
    func openMoneyInfo(symbol: String?) {
        router.openMoneyInfo(symbol: symbol)
    }
}
