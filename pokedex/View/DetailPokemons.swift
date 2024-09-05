//
//  DetailPokemons.swift
//  pokedex
//
//  Created by Eduardo Carranza maqueda on 03/09/24.
//

import SwiftUI

struct DetailPokemons: View {
    
    let PokeDta: PokeModel
    let dataModel = PokeViewModel()
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: PokeDta.imageUrl)) { photo in
                photo
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
                    .padding()
            } placeholder: {
                ProgressView()
            }
            
            Text(PokeDta.description)
                .font(.headline)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
            VStack {
                Text("Tipo: \(PokeDta.type)")
                    .font(.title2)
                    .padding()
                    .bold()
            }
            HStack {
                Text("Ataque: \(PokeDta.attack)")
                Text("Defensa: \(PokeDta.defense)")
            }
            .foregroundColor(.white)
            .font(.title2)
            .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(dataModel.getPokecolor(type: PokeDta.type))
        .padding()
        .navigationTitle(PokeDta.name)
    }
}

