//
//  SplashSwiftUI.swift
//  pokedex
//
//  Created by Eduardo Carranza maqueda on 03/09/24.
//

import SwiftUI
import Lottie

struct SplashSwiftUI: View {
    var img: String = "pokeball.json"
    var didFinish: (() -> Void)? = nil
    var body: some View {
        
        VStack{
            HStack(content: {
                Image(.pokemon)
                           .resizable()
                           .scaledToFit()
                           .aspectRatio(contentMode: .fit)
                           .padding()
                    
            })
            
            LottieView(animation: .named(img))
                .configure { LottieAnimationView in
                    LottieAnimationView.contentMode = .scaleAspectFit
                }
            
                .playbackMode(.playing(.toProgress(2, loopMode: .playOnce)))
                .animationSpeed(1.0)
                .animationDidFinish { completed in
                    didFinish?()
                }
        }
        
    }
}

#Preview {
    SplashSwiftUI()
}
