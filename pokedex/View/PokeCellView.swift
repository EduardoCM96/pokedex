//
//  PokeCellView.swift
//  pokedex
//
//  Created by Eduardo Carranza maqueda on 04/09/24.
//

import SwiftUI

struct PokeCellView: View {
    let pokemons: PokeModel
    let dataModel: PokeViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(dataModel.getPokecolor(type: pokemons.type))
                .cornerRadius(10)
            VStack {
                AsyncImage(url: URL(string: pokemons.imageUrl)) { photo in
                    photo
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit().frame(width: 80, height: 80, alignment: .bottomLeading)
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .shadow(radius: 15)
                
                Text(pokemons.name)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.leading, 0)
            }
        }
    }
}
