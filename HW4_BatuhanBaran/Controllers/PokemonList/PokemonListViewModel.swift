//
//  PokemonListViewModel.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation
import UIKit

typealias LoadingStateBlock = (LoadingState) -> Void

enum LoadingState {
    case loading
    case done
}

protocol PokemonListViewModelOutputDelegate: AnyObject {
    func navigateToPokemonDetail(with selectedPokemon: Pokemon)
    func hasMoreLoaded()
}

final class PokemonListViewModel {
    
    private let manager: PokemonListProtocol
    
    var pokemons: [Pokemon?] = []
    
    var totalCount = 0
    
    weak var delegate: PokemonListViewModelOutputDelegate?
    
    var loadingStatus = Observable<LoadingState>(value: .loading)
    
    init(manager: PokemonListProtocol) {
        self.manager = manager
    }
    
    var offset = 0
    var limit = 15
    
    func fetchPokemons(completion: @escaping ([Pokemon]) -> Void) {
        manager.fetchPokemons(offset: offset, limit: limit) { [weak self] pokemonResponse in
            guard let self = self else { return }
            self.loadingStatus.value = .loading
            switch pokemonResponse {
            case .success(let response):
                guard let pokemons = response.results else { break }
                self.totalCount = response.count ?? 0
                for pokemon in pokemons {
                    self.pokemons.append(pokemon)
                }
                self.loadingStatus.value = .done
                completion(pokemons)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func navigateToPokemonDetail(with selectedPokemon: Pokemon) {
        delegate?.navigateToPokemonDetail(with: selectedPokemon)
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
        navigateToPokemonDetail(with: self.pokemons[index] ?? Pokemon(name: "", url: ""))
    }
    
    func loadMore() {
        offset += 15
        self.loadingStatus.value = .loading
        manager.fetchPokemons(offset: offset, limit: limit) { [weak self] pokemonResponse in
            guard let self = self else { return }
            switch pokemonResponse {
            case .success(let response):
                guard let pokemons = response.results else { break }
                self.totalCount = response.count ?? 0
                for pokemon in pokemons {
                    self.pokemons.append(pokemon)
                }
                self.loadingStatus.value = .done
                self.delegate?.hasMoreLoaded()
            case .failure(let error):
                print(error)
            }
        }
    }
}
