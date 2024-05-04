//
//  CardView.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 29/02/2024.
//

import SwiftUI

struct CardView: View {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    @EnvironmentObject private var locationManager : LocationManager
    @StateObject var viewModel = HomeViewModel()
    var currentWeather: CurrentWeatherResponseBody
    var body: some View {
        VStack {
            HStack {
                Text(getCurrentDayOfWeek())
                Spacer()
                Text("\(getCurrentDate()) - \(getCurrentTime())")
                
            }
            .font(.system(size: 16))
            .foregroundStyle(.white)
            .padding([.leading,.trailing], 25)
            .padding(.top, 25)
            
            Circle()
                .foregroundStyle(Color("CarSecondaryBGColor"))
                .frame(width: 180, height: 180)
                .overlay(
                    Image("Car")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 100)
                )
                .padding(.top, 50)
            
            
            if let weatherDescription = currentWeather.weather.first?.main {
                
                if weatherDescription == "Mist" ||
                   weatherDescription == "Snow" ||
                   weatherDescription == "Rain" ||
                   weatherDescription == "Clouds" {
                    Text("We recommend you not to wash your car")
                        .font(.system(size: 24))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .frame(width: 312, alignment: .top)
                        .padding(.top, 50)
                      Spacer()
                } else {
                    Text("We recommend to wash your car ")
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .frame(width: 312, alignment: .top)
                    .padding(.top, 50)
                  Spacer()
                }
                 
                
            }
            
        }
        .frame(width: 366, height: 480)
        .background(Color("CarBGColor"))
        .cornerRadius(35)
        .shadow(radius: 5)
        .padding()
        .onReceive(locationManager.$location, perform: { location in
            guard let location = location else { return }
            locationManager.requestLocation()
        })
        
        
        
    }
 
    func getCurrentDayOfWeek() -> String {
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: currentDate)
        }
    
    func getCurrentDate() -> String {
           dateFormatter.dateFormat = "d MMM, yyyy"
           return dateFormatter.string(from: currentDate)
       }
       
       func getCurrentTime() -> String {
           dateFormatter.dateFormat = "HH:mm"
           return dateFormatter.string(from: currentDate)
       }
}
