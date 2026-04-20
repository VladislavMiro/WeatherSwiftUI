//
//  WeatherViewCoordinator.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI


final class WeatherViewCoordinator {
    
    public var path: NavigationPath = .init()
    
}

// MARK: - Extension with public methods

extension WeatherViewCoordinator {

    public func start() -> some View {
        let locationManager = LocationManager()
        let viewModel = WeatherViewModel(coordinator: self, locationManager: locationManager)
        let view = WeatherView(viewModel: viewModel)
        
        return view
    }
 
    public func showDetailView() -> some View {
        return VStack {
            Color.red
        }
    }
}
