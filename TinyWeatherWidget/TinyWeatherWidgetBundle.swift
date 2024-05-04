//
//  TinyWeatherWidgetBundle.swift
//  TinyWeatherWidget
//
//  Created by Nursultan Yelemessov on 09/03/2024.
//

import WidgetKit
import SwiftUI

@main
struct TinyWeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        TinyWeatherWidget()
        TinyWeatherWidgetLiveActivity()
    }
}
