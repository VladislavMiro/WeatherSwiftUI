//
//  WeatherViewState.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 16.04.2026.
//

import Foundation

struct WeatherViewState {
    var isRefreshing: Bool = false
    var isError: Bool = false
    var errorMessage: String = ""
    var coordinates: Coordinates?
    var data: WeatherViewOutput = .init()
}
