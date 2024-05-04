//
//  KMDetail.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 29/02/2024.
//

import SwiftUI

struct KMDetail: View {
    
    var title: String
    var temperature : String
    var specialCharacter : String
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                Text(title)
                    .font(.system(size: 15))
                  .foregroundStyle(.white)
                
                HStack(spacing: 2) {
                    Text(temperature)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.white)

                    Text(specialCharacter)
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                        .padding(.top, 11)
                }
            }
        }
    }
}

#Preview {
    KMDetail(title: "Wind now", temperature: "15", specialCharacter: "m/s")
}
