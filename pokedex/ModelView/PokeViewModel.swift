//
//  PokeViewModel.swift
//  pokedex
//
//  Created by Eduardo Carranza maqueda on 03/09/24.
//

import Foundation

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
}
