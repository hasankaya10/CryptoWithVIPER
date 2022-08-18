//
//  Interactor.swift
//  CryptoWithVIPER
//
//  Created by Hasan Kaya on 18.08.2022.
//

import Foundation

// Class, Protocol
// talks to Presenter
enum networkError : Error {
    case NetworkFailed
    case ParsingFailed
}
protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    
    func DownloadCryptos()
}
class CryptoInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    func DownloadCryptos() {
        
        guard let url = URL(string: "https://api.nomics.com/v1/currencies/ticker?key=14cd8b1ab72c2a646799018eb74bb498d7d331ba&convert=USD&per-page=100&page=1")
        else {
            return
        }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                self.presenter?.interactorDidDownloadCrypto(result: .failure(networkError.NetworkFailed))
            }
            else {
                if data != nil {
                    do {
                        let cryptos = try JSONDecoder().decode([Crypto].self, from: data!)
                        self.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
                    } catch  {
                        self.presenter?.interactorDidDownloadCrypto(result: .failure(networkError.ParsingFailed))
                    }
                } else {
                    self.presenter?.interactorDidDownloadCrypto(result: .failure(networkError.NetworkFailed))
                }
            }
        }
        task.resume()
    }
    
}
