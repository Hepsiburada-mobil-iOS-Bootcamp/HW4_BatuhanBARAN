//
//  PokemonListViewModel.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation
import UIKit

final class PokemonListViewModel {

    private let manager: PokemonListProtocol
    var pokemons = [Pokemon?]()
    
    init(manager: PokemonListProtocol) {
        self.manager = manager
    }
    
    func fetchPokemons() {
        manager.fetchPokemons(offset: 0, limit: 15) { [weak self] pokemonResponse in
            switch pokemonResponse {
            case .success(let response):
                guard let pokemons = response.results else { break }
                self?.pokemons = pokemons
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPokemonSprites(with pokemonName: String) {
        print(pokemonName)
    }
}

// MARK: - ItemListProtocol
extension PokemonListViewModel: ItemListProtocol {
    func askNumberOfSection() -> Int {
        return 1
    }
    
    func askNumberOfItem(in section: Int) -> Int {
        return self.pokemons.count
    }
    
    func askData(at index: Int) -> GenericDataProtocol? {
        return ItemTableViewCellData(pokemonName: self.pokemons[index]?.name?.capitalizingFirstLetter() ?? "")
    }
    
    func selectedData(at index: Int) {
        fetchPokemonSprites(with: self.pokemons[index]?.name ?? "")
    }
}
