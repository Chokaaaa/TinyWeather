//
//  DetailViewModel.swift
//  TinyWeather
//
//  Created by Gwinyai Nyatsoka on 6/4/2024.
//

import Foundation
import SwiftUI
import CoreLocation

class DetailViewModel: ObservableObject {
    
    let currentDate = Date()
    @Published var morningTime: String = ""
    @Published var afternoonTime: String = ""
    @Published var eveningTime: String = ""
    @Published var filteredWeatherData: [List] = []
    
    func get(weather: ResponseBody, currentWeather: CurrentWeatherResponseBody) {
        
        let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
          let dateString = dateFormatter.string(from: currentDate)
          
          let morningListResponse = weather.list.first?.dtTxt ?? ""
          morningTime = morningListResponse
        
            filteredWeatherData = weather.list.filter( { $0.dtTxt == morningTime } )
          
          if let secondWeather = weather.list[safe: 1] {
              afternoonTime = secondWeather.dtTxt
          } else {
              afternoonTime = "N/A"
          }
          
          if let thirdWeather = weather.list[safe: 2] {
              eveningTime = thirdWeather.dtTxt
          } else {
              eveningTime = "N/A"
          }
    }
    
}
