//
//  Sprites.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import Foundation

struct Sprites: Codable {
    let sprites: Sprite?
    let weight: Int?
    let height: Int?
    let id: Int?
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
