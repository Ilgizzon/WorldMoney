//
//  InfoScreenPresenter.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import Foundation
import RxSwift

class InfoScreenPresenter {
    
    enum RequestState {
        case done, inProgress
    }
    
    weak var view: InfoScreenView?
    private let interactor: InfoScreenInteractor
    private let router: InfoScreenRouter
    private var disposableBag = DisposeBag()
    private var requestState: RequestState = .done
    
    init(
        interactor: InfoScreenInteractor,
        router: InfoScreenRouter
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
        interactor.getMoney()
            .subscribe(onNext: { [weak self] money in
                self?.view?.setData(money)
                self?.view?.showLoading(false)
                self?.requestState = .done
            }).disposed(by: disposableBag)
    }
    
    func openMainScreen() {
        router.openMainScreen()
    }
}
