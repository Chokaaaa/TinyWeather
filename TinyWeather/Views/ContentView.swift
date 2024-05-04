//
//  ContentView.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 28/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    var body: some View {
        ZStack {
            
            if showSplash {
                SplashScreenView()
//                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5))
            } else {
                HomeView()
            }
            
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.showSplash = false
                }
            }
            
        })
    }
}

#Preview {
    ContentView()
}
