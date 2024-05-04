//
//  ListRow.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 29/02/2024.
//

import SwiftUI

struct ListRow: View {
    
    var imageName: String
    var text: String
    var tempText: String
    
    var body: some View {
        HStack(spacing: 25) {
         
            Text("In the morning")
                .font(.system(size: 15))
                .foregroundStyle(Color("ListTextColor"))
            
            Spacer()
            
            HStack {
                Text(tempText)
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
        }
        .padding()
    }
}

#Preview {
    ListRow(imageName: "SunIcon", text: "Morning", tempText: "21°")
}
