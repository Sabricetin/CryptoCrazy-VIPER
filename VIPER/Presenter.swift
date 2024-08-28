//
//  Presenter.swift
//  CryptoCrazy-VIPER
//
//  Created by Sabri Çetin on 26.08.2024.
//

import Foundation

// talks to -> interactor , router , view 
// Class , protocol


enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}


protocol AnyPresenter {
    var router : AnyRouter?{get set}
    var ınteractor : AnyInteractor? { get set}
    var  view : AnyView? { get set }
    
    func interactorDidDownloadCrypto (result : Result<[Crypto], Error>)
    
    
    
}

class CryptoPresenter : AnyPresenter {
    var router: (any AnyRouter)?
    
    var ınteractor: (any AnyInteractor)? {
        didSet {
            ınteractor?.downloadCryptos()
        }
    }
    
    
    
    var view: (any AnyView)?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], any Error>) {
        
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
            //view.update error
        case .failure(let error) :
            view?.update(with: "Try Age Later . . .")
        }
        
    }
    
    
}

