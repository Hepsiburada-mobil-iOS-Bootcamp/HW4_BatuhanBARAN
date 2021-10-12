//
//  File.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation

struct PokemonResult: Codable {
    let results: [Pokemon]?
}

struct Pokemon: Codable {
    let name: String?
    let url: String?
}

struct Sprites: Codable {
    let sprites: Sprite?
    let weight: Int?
}

struct Sprite: Codable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_shiny: String?
    let front_shiny_female: String?
}
