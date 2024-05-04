//
//  ViewModel.swift
//  TinyWeather
//
//  Created by Gwinyai Nyatsoka on 7/4/2024.
//

import Foundation

class ViewModel {
    
    var responseBody: CurrentWeatherResponseBody?
    
    func getCurrentWeather() async {
        
        guard let latitude = UserDefaults(suiteName: "group.com.tinyweather.widgets")?.double(forKey: "latitude"),
              let longitude = UserDefaults(suiteName: "group.com.tinyweather.widgets")?.double(forKey: "longitude") else {
            return
        }
        
        let apiKey = "18bfb0981d3d08cdde21e64a65c1240f"

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else { fatalError("Missing URL")}
        
        print("current url for current \(url)")
        

        let urlRequest = URLRequest(url: url)
        
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            return
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        guard let decodedData = try? JSONDecoder().decode(CurrentWeatherResponseBody.self, from: data) else {
            return
        }
        
        responseBody = decodedData
    }
    
}
