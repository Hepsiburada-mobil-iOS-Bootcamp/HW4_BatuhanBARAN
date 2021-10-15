//
//  PokemonDetailViewModel.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import Foundation

final class PokemonDetailViewModel {
    
    var loadingStatus = Observable<LoadingState>(value: .loading)
    private let spriteManager: PokemonSpritesManager
    var selectedPokemon: Pokemon
    var sprite: Sprites?
    
    init(selectedPokemon: Pokemon,spriteManager: PokemonSpritesManager) {
        self.selectedPokemon = selectedPokemon
        self.spriteManager = spriteManager
    }
    
    func fetchSprites(completion: @escaping (Sprites?) -> Void) {
        spriteManager.fetchPokemonSprites(url: selectedPokemon.url ?? "") { [weak self] selectedPokemonSprites in
            self?.sprite = selectedPokemonSprites
            self?.loadingStatus.value = .done
            completion(selectedPokemonSprites)
        }
    }
}
