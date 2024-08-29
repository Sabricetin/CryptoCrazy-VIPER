//
//  Interactor.swift
//  CryptoCrazy-VIPER
//
//  Created by Sabri Çetin on 26.08.2024.
//

import Foundation

// talks to -> presenter
// Class , protocol

protocol AnyInteractor {
    var presnter : AnyPresenter? {get set}

    
    func downloadCryptos ()
}
class CryptoInteractor : AnyInteractor {
    var presnter: (any AnyPresenter)?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response , error in
            guard let data = data , error == nil else {
                self?.presnter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                
                self?.presnter?.interactorDidDownloadCrypto(result: .success(cryptos))
                
            } catch {
                self?.presnter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
}
