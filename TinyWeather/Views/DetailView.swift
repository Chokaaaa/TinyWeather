//
//  CardDetailView.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 29/02/2024.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel = DetailViewModel()
    
    @State var weather : ResponseBody
    @State var currentWeather: CurrentWeatherResponseBody
    
    @EnvironmentObject private var locationManager : LocationManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                
                CardDetailView(currentWeather: currentWeather)
                
                HStack(spacing: 30) {
                    
                    let speed = currentWeather.wind.speed
                    
                    KMDetail(title: "Wind now", temperature: String(speed), specialCharacter: "m/s")
                    
                    let humidity =  currentWeather.main.humidity
                    
                    KMDetail(title: "Humidity", temperature: String(humidity), specialCharacter: "%")
                    
                    let clouds = currentWeather.clouds.all
                    
                    KMDetail(title: "Cloudiness", temperature: String(clouds), specialCharacter: "%")
                }
                .frame(width: 350, height: 110)
                .background(Color("CarBGColor"))
                .cornerRadius(35)
                .shadow(radius: 5)
                .padding()
                .padding(.top, -15)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Weather for today")
                        .font(.system(size: 26, weight: .semibold))
                        .padding(.leading, 25)
                    
                    VStack {
                            
                            HStack(spacing: 25) {
                                
                                Text("In the morning")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color("ListTextColor"))
                                
                                Spacer()
                                
                                HStack {
                                    
                                    let roundedMorningTemp = viewModel.filteredWeatherData.first?.main.feelsLike.roundDouble() ?? ""
                                    Text(String(roundedMorningTemp))
                                    
                                    
                                    if let weather = weather.list.first?.weather {
                                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.first?.icon ?? "")@2x.png")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                    
                                }
                            }
                            .padding()
                        
                        Divider()
                        
                        if let weatherData = weather.list[safe: 1]?.weather {
                            HStack(spacing: 25) {
                                Text("Afternoon")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color("ListTextColor"))
                                
                                Spacer()
                                
                                
                                HStack {
                                    
                                    let roundedAfternoonTemp = weather.list[safe: 1]?.main.feelsLike.roundDouble() ?? ""
                                    Text(String(roundedAfternoonTemp))
                                    
                                    
                                    if let weather = weatherData.first {
                                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                }
                                
                            }
                            .padding()
                        }
                        
                        Divider()
                        
                        if let weatherData = weather.list[safe: 2]?.weather {
                            HStack(spacing: 25) {
                                Text("In the evening")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color("ListTextColor"))
                                
                                Spacer()
                                
                                HStack {
                                    let roundedEveningTemp = weather.list[safe: 2]?.main.feelsLike.roundDouble() ?? ""
                                    Text(String(roundedEveningTemp))
                                    
                                    if let weather = weatherData.first {
                                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        Divider()
                        
                    }
                    .padding([.leading, .trailing], 10)
                }
                
            }
        }
        .onAppear(perform: {
            viewModel.get(weather: weather, currentWeather: currentWeather)
        })
        .onReceive(locationManager.$location, perform: { location in
            guard let location = location else { return }
            
        })
    }
    
}

//#Preview {
//    DetailView(weather: <#ResponseBody#>, currentWeather: <#CurrentWeatherResponseBody#>)
//}
