//
//  HomeView.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 28/02/2024.
//

import SwiftUI
import CardStack
import CoreLocation

struct HomeView: View {
    
    @EnvironmentObject private var locationManager : LocationManager
    @StateObject var viewModel = HomeViewModel()
    @State private var showDetailView = false
    @State private var hasFetchedWeather = false
    
    var body: some View {
        VStack {
            
            if let weather = viewModel.currentWeather {
                CardView(currentWeather: weather)
                    .padding(.top, 50)
            }
            
            Spacer()
            
            Button(action: {
                guard viewModel.currentWeather != nil,
                      viewModel.weatherData != nil else {
                    return
                }
                showDetailView.toggle()
            }, label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("Why is that? 🤔")
              .font(
                Font.custom("Inter", size: 17)
                  .weight(.semibold)
              )
              .foregroundStyle(Color("MainButtonTextColor"))
            }
            .padding([.leading,.trailing],93)
            .padding([.leading,.trailing], 23)
            .frame(height: 70)
            .background(Color("MainButtonBgColor"))
            .cornerRadius(13)
            })
        }
        .alert("Location Not Available", isPresented: $locationManager.showLocationDeniedError, actions: {
            Button(action: {
                
            }, label: {
                Text("OK")
            })
        }, message: {
            Text("Please allow location services in settings to see current weather.")
        })
        .onAppear {
            locationManager.requestLocation()
        }
        .onReceive(locationManager.$location, perform: { location in
                  guard let location = location else { return }
                  if !hasFetchedWeather {
                      hasFetchedWeather = true
                      
                      Task {
                          
                          await withTaskGroup(of: Void.self) { group in
                              group.addTask {
                                  await viewModel.fetchCurrentWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                              }
                              group.addTask {
                                  await viewModel.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                              }
                          }
                      }
                  }
              })
        .sheet(isPresented: $showDetailView, content: {
            DetailView(weather: viewModel.weatherData!, currentWeather: viewModel.currentWeather!)
                .presentationDetents([ .large])
                .presentationDragIndicator(.visible)
        })
    }
    
}

#Preview {
    HomeView()
}
