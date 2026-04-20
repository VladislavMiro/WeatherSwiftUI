//
//  WeatherViewModel.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 16.04.2026.
//

import Foundation
import CoreLocation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published public var state: WeatherViewState = .init()
    @Published public var coordinator: WeatherViewCoordinator
    
    // MARK: - Private properties
    
    private let locationManager: LocationManagerProtocol?
    private var cancelable: Set<AnyCancellable> = []
    
    // MARK: - initialaizers
    
    public init(coordinator: WeatherViewCoordinator, locationManager: LocationManagerProtocol) {
        self.coordinator = coordinator
        self.locationManager = locationManager
        
        bind()
    }
    
}

// MARK: - Extension with WeatherViewModelProtocol implementations

extension WeatherViewModel: WeatherViewModelProtocol {
    
    public func send(_ intent: WeatherViewIntent) {
        switch intent {
        case .fetchData:
            fetchData()
        }
    }
    
}

// MARK: - Extension with private methods

private extension WeatherViewModel {
    
    func fetchData() {
        if let locationManager = locationManager {
            locationManager.getCurrentLocation()
        } else {
            fetchWeather()
        }
    }
    
    func bind() {
        locationManager?.coordinates.sink { [weak self] coordinates in
            self?.state.coordinates = coordinates
            self?.fetchWeather()
        }
        .store(in: &cancelable)
    }
    
    func fetchWeather() {
        debugPrint("Fetchet coordinates: ", state.coordinates)
    }
    
}
