//
//  ContentView.swift
//  pokedex
//
//  Created by Eduardo Carranza maqueda on 03/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isActive: Bool = true
    
    var body: some View {
        ZStack{
            if isActive {
                SplashSwiftUI()
            } else{
                Pokedex()
            }
        }
        .onAppear(perform: {
            withAnimation(.easeInOut(duration: 3).delay(5)) {
                isActive.toggle()
            }
        })
    }
}

#Preview {
    ContentView()
}

struct Pokedex: View {
    @StateObject var response = PokeViewModel()
    @State private var pokeSerch = ""
    
    private let pokeColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: pokeColumns) {
                    ForEach(response.filterPoke, id: \.self) { pokemons in
                        
                        NavigationLink(destination: DetailPokemons(PokeDta: pokemons)) {
                            PokeCellView(pokemons: pokemons, dataModel: response)
                        }
                    }
                }.padding()
            }
            .searchable(text: $pokeSerch, prompt: "Buscar aquí tu pokemon")
            .onChange(of: pokeSerch, { oldValue, NewValue in
                withAnimation {
                    response.pokeFilter(name: NewValue)
                }
            })
            .navigationBarTitle("Lista de Pokemons")
        }
    }
}

