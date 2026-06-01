//
//  WeatherNetworkServiceProtocol.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 20.04.2026.
//

import Foundation

protocol WeatherNetworkServiceProtocol {
    func fetchWeather(by coord: Coordinates) async throws -> WeatherResponse
}
