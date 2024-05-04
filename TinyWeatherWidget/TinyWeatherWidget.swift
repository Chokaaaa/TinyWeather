//
//  TinyWeatherWidget.swift
//  TinyWeatherWidget
//
//  Created by Nursultan Yelemessov on 09/03/2024.
//

import WidgetKit
import SwiftUI

var lastUpdateTime = Date()

struct Provider: AppIntentTimelineProvider {
    
    let viewModel = ViewModel()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), viewModel: ViewModel(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), viewModel: ViewModel(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
    
        await viewModel.getCurrentWeather()
        
        let entry = SimpleEntry(date: Date(), viewModel: viewModel, configuration: configuration)
        
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: Date())
        
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate!))
        
        return timeline
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        //        let currentDate = Date()
        //        for hourOffset in 0 ..< 3 {
        //            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        //            let entry = SimpleEntry(date: entryDate, configuration: configuration)
        //            entries.append(entry)
        //        }
            
    }
        
}

struct SimpleEntry: TimelineEntry {
    let date: Date
//    let currentWeather: CurrentWeatherWidgetModel?
    let viewModel: ViewModel
    let configuration: ConfigurationAppIntent
}

struct TinyWeatherWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "d MMM"
          return formatter
      }()


    var body: some View {
        
                switch widgetFamily {
                case .systemSmall:
                    
                    ZStack {
                        Color("WidgetBackground")
                        VStack(spacing: 15) {
                            HStack(spacing: 30) {
                                Circle()
                                    .foregroundStyle(Color("CarSecondaryBGColor"))
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image("Car")
                                            .resizable()
                                            .foregroundStyle(.white)
                                            .frame(width: 35, height: 35)
                                    )
                                if let temp = entry.viewModel.responseBody?.main.temp {
                                    
                                    VStack(spacing: 0) {
                                        Text("\(temp.roundDouble())°")
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                    }
                                }
//                                    
//                                    Text("\(entry.date, formatter: dateFormatter)")
//                                        .font(.system(size: 10))
//                                        .fontWeight(.bold)
//                                        .foregroundStyle(.white)
                                    
                                
                            }
                            
                            if let weatherDescription = entry.viewModel.responseBody?.weather.first?.main {
                                
                                if weatherDescription == "Mist" ||
                                   weatherDescription == "Snow" ||
                                   weatherDescription == "Rain" ||
                                   weatherDescription == "Clouds" {
                                    Text("We recommend you not to wash your car")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                      .foregroundStyle(.white)
                                      .multilineTextAlignment(.center)
                                    
                                } else {
                                    Text("We recommend to wash your car ")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                      .foregroundStyle(.white)
                                      .multilineTextAlignment(.center)
                                    
                                }
                                
                            } else {
                                Text("Loading...")
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                  .foregroundStyle(.white)
                                  .multilineTextAlignment(.center)
                                Spacer()
                            }
                                  
                            
                        }
                    }
                case .systemMedium:
                    ZStack {
                        Color("WidgetBackground")
                        VStack(spacing: -15) {
                            HStack(spacing: 15) {
                                Circle()
                                    .foregroundStyle(Color("CarSecondaryBGColor"))
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image("Car")
                                            .resizable()
                                            .foregroundStyle(.white)
                                            .frame(width: 35, height: 35)
                                    )
                                
                        
                                
                                VStack(spacing: 3) {
                                    if let temp = entry.viewModel.responseBody?.main.temp {
                                        Text("\(temp.roundDouble())°")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                    }
                                    
                                }
                                .padding(.bottom, 5)
                                .foregroundStyle(.white)
                                
                                Spacer()
                                
                                VStack {
                                    
                                    Text("\(entry.date.formatted(.dateTime.weekday(.wide)))")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                    
                                    Text("\(entry.date, formatter: dateFormatter)")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .padding(.leading)
                                }
                                
                            }
                            .padding(.trailing)
                            .padding(.bottom, 10)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                if let weatherDescription = entry.viewModel.responseBody?.weather.first?.main {
                                    
                                    if weatherDescription == "Mist" ||
                                       weatherDescription == "Snow" ||
                                       weatherDescription == "Rain" ||
                                       weatherDescription == "Clouds" {
                                        Text("We recommend you not to wash your car")
                                            .font(.system(size: 20))
                                            .lineLimit(2)
                                            .foregroundStyle(.white)
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 25)
                                            .padding([.leading,.trailing])
//                                        Spacer()
                                    } else {
                                        Text("We recommend to wash your car ")
                                            .font(.system(size: 20))
                                            .lineLimit(2)
                                            .foregroundStyle(.white)
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 25)
                                            .padding([.leading,.trailing])
//                                        Spacer()
                                    }
                                    
                                } else {
                                    Text("Loading...")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.white)
                                        .padding(.top, 25)
                                        .padding([.leading,.trailing])
                                    Spacer()
                                }
                                
                            }
                            
                            
                        }
                    }
                    
                case .systemLarge:
                    
                    VStack {
                        HStack {
                            Text("\(entry.date.formatted(.dateTime.weekday(.wide)))")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            Spacer()
                            Text("\(entry.date, formatter: dateFormatter)")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.leading)
                            
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
                                
                                if let temp = entry.viewModel.responseBody?.main.temp {
                                    Text("\(temp.roundDouble())")
                                        .font(.system(size: 53, weight: .bold))
                                        .foregroundStyle(.white)
                                        .padding(.top,5)
                                        .padding(.leading, 15)
                                    
                                    
                                    Text("°")
                                        .font(.system(size: 33, weight: .regular))
                                        .foregroundStyle(.white)
                                        .opacity(0.5)
                                    
                                }
                            }
                            
//                            Text("We recommend you not to wash your car")
//                                .font(.system(size: 25))
//                                .fontWeight(.semibold)
//                                .multilineTextAlignment(.center)
//                                .foregroundStyle(.white)
//                                .padding(.top, 20)
//                                .padding([.leading,.trailing])
//                            Spacer()
                            
                            
                            if let weatherDescription = entry.viewModel.responseBody?.weather.first?.main {
                                Text(weatherDescription)
                                        .font(.system(size: 25, weight: .bold))
                                        .foregroundStyle(.white)
                                
                                if weatherDescription == "Mist" ||
                                   weatherDescription == "Snow" ||
                                   weatherDescription == "Rain" ||
                                   weatherDescription == "Clouds" {
                                    Text("We recommend you not to wash your car")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .padding(.top, 20)
                                        .padding([.leading,.trailing])
                                    Spacer()
                                } else {
                                    Text("We recommend to wash your car ")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .padding(.top, 20)
                                        .padding([.leading,.trailing])
                                    Spacer()
                                }
                                 
                                
                            } else {
                                Text("Loading...")
                                    .font(.system(size: 20))
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.white)
                                    .padding(.top, 25)
                                    .padding([.leading,.trailing])
                                Spacer()
                            }
                            
                          
                        }
                        
                     
                        
                    }
                    .frame(width: 350, height: 400)
                    .background(Color("CarBGColor"))
                    .cornerRadius(35)
//                    .shadow(radius: 5)
                    .padding()
                    
//                    ZStack {
//                        Color("WidgetBackground")
//                        VStack {
//                            HStack(spacing: 15) {
//                                Circle()
//                                    .foregroundStyle(Color("CarSecondaryBGColor"))
//                                    .frame(width: 60, height: 60)
//                                    .overlay(
//                                        Image("Weather")
//                                            .resizable()
//                                            .foregroundStyle(.white)
//                                            .frame(width: 35, height: 35)
//                                    )
//                                
//                                Spacer()
//                                
//                                HStack(spacing: 5) {
//                                    Text("\(entry.date, formatter: dateFormatter),")
//                                        .font(.system(size: 20))
//                                    
//                                    
//                                    Text("+4°")
//                                        .font(.system(size: 20))
//                                        .fontWeight(.bold)
//                                        
//                                    
//                                }
//                                .foregroundStyle(.white)
//                            }
//                            .padding(.trailing)
//                            .padding(.bottom, 25)
//                            
//                            VStack(alignment: .leading, spacing: 45) {
//                                Text("Not a good time to wash your car.")
//                                    .font(.system(size: 30))
//                                    .fontWeight(.medium)
//                                  .foregroundStyle(.white)
//                                
//                                
//                                Text("Don't forget to take an umbrella too!")
//                                    .font(.system(size: 25))
//                                    .foregroundStyle(.white)
//                                
//                            }
//                            
//                            
//                        }
//                    }
                default:
                    Text("No Widget Default")
                }
        
        
    }
}

struct TinyWeatherWidget: Widget {
    let kind: String = "TinyWeatherWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TinyWeatherWidgetEntryView(entry: entry)
                .containerBackground(Color("WidgetBackground"), for: .widget)
        }
        .configurationDisplayName("Current Weather Widget")
        .description("Widget with a latest update for a current weather")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

//#Preview(as: .systemSmall) {
//    TinyWeatherWidget()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//}


struct TinyWeatherWidgetPreview: PreviewProvider {
    static var previews: some View {
        Group {
            TinyWeatherWidgetEntryView(entry: SimpleEntry(date: Date(), viewModel: ViewModel(), configuration: .smiley))
                .containerBackground(Color("WidgetBackground"), for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            TinyWeatherWidgetEntryView(entry: SimpleEntry(date: Date(), viewModel: ViewModel(), configuration: .smiley))
                .containerBackground(Color("WidgetBackground"), for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            TinyWeatherWidgetEntryView(entry: SimpleEntry(date: Date(), viewModel: ViewModel(), configuration: .smiley))
                .containerBackground(Color("WidgetBackground"), for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            
            
        }
    }
}
