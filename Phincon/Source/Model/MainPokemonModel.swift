//
//  MainPokemonModel.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import Foundation

// MARK: - PokemonResponse
struct PokemonResponse: Codable {
    let count: Int?
    let results: [Response]?

}

// MARK: - Result
struct Response: Codable {
    let name: String?
    let url: String?
}
