//
//  InfoScreenPresenter.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import Foundation
import RxSwift

class InfoScreenPresenter {
    
    weak var view: InfoScreenView?
    private let interactor: InfoScreenInteractor
    private let router: InfoScreenRouter
    private var disposableBag = DisposeBag()
    
    init(
        interactor: InfoScreenInteractor,
        router: InfoScreenRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    func setupData() {
        view?.showLoading(true)
        interactor.getMoney()
            .subscribe(onNext: { [weak self] money in
                self?.view?.setData(money)
                self?.view?.showLoading(false)
            }).disposed(by: disposableBag)
    }
    
    func openMainScreen() {
        router.openMainScreen()
    }
}
