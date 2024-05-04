//
//  CardDetailView.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 29/02/2024.
//

import SwiftUI
import CoreLocation

struct CardDetailView: View {

    @EnvironmentObject private var locationManager : LocationManager
    @StateObject var viewModel = HomeViewModel()
    var currentWeather: CurrentWeatherResponseBody
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            HStack {
                Text(getCurrentDayOfWeek())
                Spacer()
                Text(getCurrentDate())
                
            }
            .font(.system(size: 16))
            .foregroundStyle(.white)
            .padding([.leading,.trailing], 25)
            .padding(.top, 25)
            
            Circle()
                .foregroundStyle(Color("CarSecondaryBGColor"))
                .frame(width: 100, height: 100)
                .overlay(
                    Image("Car")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                )
                .padding(.top, 15)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    
                    
                    Text(currentWeather.main.feels_like.roundDouble())
                            .font(.system(size: 53, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.top,5)
                            .padding(.leading, 15)
                    
                
                    Text("°")
                        .font(.system(size: 33, weight: .regular))
                        .foregroundStyle(.white)
                        .opacity(0.5)
                    
                }
                
                if let weatherDescription = currentWeather.weather.first?.main {
                    Text(weatherDescription)
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.white)
                    
                    if weatherDescription == "Mist" ||
                       weatherDescription == "Snow" ||
                       weatherDescription == "Rain" ||
                       weatherDescription == "Clouds" {
                        Text("We recommend you not to wash your car")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding(.top, 25)
                            .padding([.leading,.trailing])
                        Spacer()
                    } else {
                        Text("We recommend to wash your car ")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding(.top, 25)
                            .padding([.leading,.trailing])
                        Spacer()
                    }
                     
                    
                }
                
              
            }
            
         
            
        }
        .frame(width: 350, height: 400)
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
    
}
