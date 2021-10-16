//
//  PokemonListApiServiceProvider.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 16.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

class PokemonListApiServiceProvider: ApiServiceProvider<PokemonResult> {
    
    var limit: Int = 0
    var offset: Int = 0
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        super.init(baseUrl: APIPaths.baseUrl.rawValue, path: APIPaths.endPoint.rawValue + "/?limit=\(limit)&offset=\(offset)")
    }
}
