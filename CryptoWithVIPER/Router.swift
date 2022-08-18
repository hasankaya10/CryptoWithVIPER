//
//  Router.swift
//  CryptoWithVIPER
//
//  Created by Hasan Kaya on 18.08.2022.
//

import Foundation
import UIKit

// Class, Protocol
// EntryPoint
typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entryPoint: EntryPoint? {get}
    static func StartExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter {
    var entryPoint: EntryPoint?
    
    
    static func StartExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var interactor : AnyInteractor = CryptoInteractor()
        var presenter : AnyPresenter = CryptoPresenter()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.entryPoint = view as? EntryPoint
        return router
    }
    
    
}
