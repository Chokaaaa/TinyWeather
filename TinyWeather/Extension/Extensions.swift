//
//  Extensions.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 01/03/2024.
//

import Foundation

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
