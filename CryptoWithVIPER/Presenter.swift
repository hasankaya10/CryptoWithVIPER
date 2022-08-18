//
//  Presenter.swift
//  CryptoWithVIPER
//
//  Created by Hasan Kaya on 18.08.2022.
//

import Foundation

// Class, Protocol
// talks to interactor, router , view

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
}
class CryptoPresenter : AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.DownloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            // view.update
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Try Again Later...")
        }
    }
    
    
}
