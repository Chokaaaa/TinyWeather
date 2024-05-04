//
//  SplashScreenView.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 28/02/2024.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color("SplashColor")
                .ignoresSafeArea(edges: .all)
            
            Image("SplashIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220, alignment: .center)
                .padding(.bottom, 50)
            
        }
    }
}

#Preview {
    SplashScreenView()
}
