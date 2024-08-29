//
//  Router.swift
//  CryptoCrazy-VIPER
//
//  Created by Sabri Çetin on 26.08.2024.
//

import Foundation
import UIKit

// Class , protocol
// Entrypoint

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry : EntryPoint? {get}
    
    static func startExecution () -> AnyRouter
}
class CryptoRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> any AnyRouter {
        
        let router = CryptoRouter ()
        
        var view    : AnyView = CryptoViewController()
        var presnter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presnter = presnter
        presnter.view = view
        presnter.router = router
        presnter.ınteractor = interactor
        interactor.presnter = presnter
        router.entry = view as? EntryPoint
        return router
    }
}
