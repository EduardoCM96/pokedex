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
    var body: some View {
        Text("Pokedex")
    }
}
