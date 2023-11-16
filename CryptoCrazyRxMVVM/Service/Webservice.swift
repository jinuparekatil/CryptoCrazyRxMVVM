//
//  Webservice.swift
//  CryptoCrazyRxMVVM
//
//  Created by Jinu on 12/11/2023.
//

import Foundation

class Webservice{
    enum CryptoError: Error{
        case serverError
        case  parsingError
    }
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto],CryptoError>)-> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(.failure(CryptoError.serverError) )
            } else if let data = data{
                
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList{
                    completion(.success(cryptoList))
                }else{
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
}
