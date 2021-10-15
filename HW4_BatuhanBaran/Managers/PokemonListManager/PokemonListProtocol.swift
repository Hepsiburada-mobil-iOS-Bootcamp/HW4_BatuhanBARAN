//
//  PokemonListProtocol.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

typealias PokemonListResult = Result<PokemonResult, ErrorResponse>

protocol PokemonListProtocol {
    
//    private(set) var offSet: String { set }
//    private(set) var limit: String { set }
    
    func fetchPokemons(offset: Int, limit: Int, completion: @escaping (PokemonListResult) -> Void)
}
