//
//  PokemonListManager.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

enum APIPaths: String {
    case baseUrl = "https://pokeapi.co/api/v2/"
    case endPoint = "pokemon"
}

class PokemonListManager: PokemonListProtocol {
    
    typealias PokemonListResult = Result<PokemonResult, ErrorResponse>
    
    static let shared = PokemonListManager()
    
    func fetchPokemons(offset: Int, limit: Int, completion: @escaping (PokemonListResult) -> Void) {
        guard let url = URL(string: APIPaths.baseUrl.rawValue + APIPaths.endPoint.rawValue + "?limit=\(limit)&offset=\(offset)") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        APIManager.shared.executeRequest(urlRequest: urlRequest) { (result: PokemonListResult) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
