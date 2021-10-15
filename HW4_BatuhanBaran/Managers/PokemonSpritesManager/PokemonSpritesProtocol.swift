//
//  PokemonSpritesProtocol.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import Foundation

protocol PokemonSpritesProtocol {
    func fetchPokemonSprites(url: String, completion: @escaping (Sprites?) -> Void)
}

