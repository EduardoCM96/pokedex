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
            withAnimation(.easeInOut(duration: 5).delay(2)) {
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
    var body: some View {
        NavigationStack {
            List(response.listPoke, id: \.id) { pokemon in
                Text(pokemon.name)
            }
        }
    }
}
