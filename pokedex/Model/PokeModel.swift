//
//  PokeModel.swift
//  pokedex
//
//  Created by Eduardo Carranza maqueda on 03/09/24.
//

import Foundation

struct PokeModel: Codable, Hashable {
    let id, attack, defense: Int
    let description, name, imageUrl, type : String
}
