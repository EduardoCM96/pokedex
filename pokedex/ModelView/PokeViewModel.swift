//
//  PokeViewModel.swift
//  pokedex
//
//  Created by Eduardo Carranza maqueda on 03/09/24.
//

import SwiftUI

class PokeViewModel: ObservableObject {
    @Published var listPoke = [PokeModel]()
    @Published var filterPoke = [PokeModel]()
    
    init(){
        getPokemons()
    }
    
    func getPokemons() {
        Network.link.getData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let listPoke):
                    print("listPokemon \(listPoke.count)")
                    self.listPoke = listPoke
                    self.filterPoke = listPoke
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func pokeFilter (name: String) {
        if name.isEmpty {
            filterPoke = listPoke
        } else {
            filterPoke = listPoke.filter({ pokemon in
                pokemon.name.lowercased().contains(name.lowercased())
            })
        }
    }
    func getPokecolor(type: String) -> Color {
        switch type {
        case "poison":
            return .green
        case "fire":
            return .red
        case "water":
            return .cyan
        case "electric":
            return .yellow
        case "ground":
            return .brown
        case "flying":
            return .teal
        case "normal", "rock":
            return Color.secondary
        case "fighting":
            return .gray
        case "bug", "grass":
            return .indigo
        case "ice", "steel":
            return .mint
        case "fairy", "psychic", "dragon":
            return .purple
        default:
            return .white
        }
    }
}
