//
//  PokemonSpritesManager.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

class PokemonSpritesManager: PokemonSpritesProtocol {
    
    typealias PokemonSpriteResult = Result<Sprites, ErrorResponse>
    
    var sprites = [Sprites?]()
    static let shared = PokemonListManager()
    
    func fetchPokemonSprites(url: String, completion: @escaping (Sprites?) -> Void) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        
        APIManager.shared.executeRequest(urlRequest: urlRequest) { (result: PokemonSpriteResult) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
