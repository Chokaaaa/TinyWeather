//
//  HomeViewModel.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 01/03/2024.
//

import Foundation
import CoreLocation

@MainActor
class HomeViewModel : ObservableObject {
    
    @Published var weatherData : ResponseBody?
    @Published var currentWeather: CurrentWeatherResponseBody?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        print("fetching weather")
        do {
            weatherData = try await getCurrentWeather(latitude: latitude, longitude: longitude)
            print("fetching weather complete")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        print("fetching current weather")
        do {
            currentWeather = try await getCurrentForecast(latitude: latitude, longitude: longitude)
            print("fetching current weather complete")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        let apiKey = "18bfb0981d3d08cdde21e64a65c1240f"

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&cnt=3&appid=\(apiKey)&units=metric"
        
        ) else { fatalError("Missing URL")}
        
        print("5 days forecats \(url)")
        

        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
    
    private func getCurrentForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentWeatherResponseBody {
        let apiKey = "18bfb0981d3d08cdde21e64a65c1240f"

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else { fatalError("Missing URL")}
        
        print("current url for current \(url)")
        

        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(CurrentWeatherResponseBody.self, from: data)
        
        return decodedData
    }
    
    
    
    
    
}
