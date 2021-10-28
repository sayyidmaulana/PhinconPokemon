//
//  NetworkRequest.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

let SERVER = "https://pokeapi.co/api/v2/"

let endPointPokemon = SERVER + "pokemon/"

let detailPokemon = "pokemon/"

func filterPokemon(idPokemon: String) -> String {
    return SERVER + detailPokemon + idPokemon
}
