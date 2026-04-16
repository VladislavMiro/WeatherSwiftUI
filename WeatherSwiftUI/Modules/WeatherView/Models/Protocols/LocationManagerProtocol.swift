//
//  LocationManagerProtocol.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 16.04.2026.
//

import Foundation
import Combine

protocol LocationManagerProtocol: AnyObject {
    var coordinates: AnyPublisher<Coordinates, Never> { get }

    func getCurrentLocation()
}
