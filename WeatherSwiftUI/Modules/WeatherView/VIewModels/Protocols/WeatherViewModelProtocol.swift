//
//  WeatherViewModelProtocol.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 16.04.2026.
//

import Foundation

protocol WeatherViewModelProtocol: AnyObject {
    var state: WeatherViewState { get }
    
    func send(_ intent: WeatherViewIntent)
}
