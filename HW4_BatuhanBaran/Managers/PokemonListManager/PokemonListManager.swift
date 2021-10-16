//
//  PokemonListManager.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

class PokemonListManager: PokemonListProtocol {
    
    typealias PokemonListResult = Result<PokemonResult, ErrorResponse>
    
    static let shared = PokemonListManager()
    
    func fetchPokemons(offset: Int, limit: Int, completion: @escaping (PokemonListResult) -> Void) {
        
        do {
            let urlRequest = try PokemonListApiServiceProvider(limit: limit, offset: offset).returnUrlRequest()
            
            APIManager.shared.executeRequest(urlRequest: urlRequest) { (result: PokemonListResult) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        } catch let error {
            print("error : \(error)")
        }

    }
}
