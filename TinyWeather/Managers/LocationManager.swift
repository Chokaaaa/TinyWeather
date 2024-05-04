//
//  LocationManager.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 01/03/2024.
//

import Foundation
import CoreLocation

class LocationManager : NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var showLocationDeniedError = false
    @Published var location : CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        UserDefaults(suiteName: "group.com.tinyweather.widgets")?.set(Double(location.coordinate.latitude), forKey: "latitude")
        UserDefaults(suiteName: "group.com.tinyweather.widgets")?.set(Double(location.coordinate.longitude), forKey: "longitude")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("#DEBUG failed to fetch a location due \(error.localizedDescription)")
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showLocationDeniedError = true
        default:
            break
        }
        
    }
    
}
