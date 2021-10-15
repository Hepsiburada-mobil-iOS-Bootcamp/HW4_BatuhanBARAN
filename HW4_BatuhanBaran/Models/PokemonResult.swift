//
//  File.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation

struct PokemonResult: Codable {
    let count: Int?
    let results: [Pokemon]?
}

struct Pokemon: Codable {
    let name: String?
    let url: String?
}

