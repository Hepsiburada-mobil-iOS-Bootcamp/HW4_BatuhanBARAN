//
//  PokemonDetailServiceProvider.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 16.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

class PokemonDetailServiceProvider: ApiServiceProvider<Sprites> {

    var pokemonUrl: String = ""
    
    init(pokemonUrl: String) {
        self.pokemonUrl = pokemonUrl
        super.init(baseUrl: pokemonUrl)
    }
}
