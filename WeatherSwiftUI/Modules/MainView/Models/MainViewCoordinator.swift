//
//  MainViewCoordinator.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 05.04.2026.
//

import SwiftUI
import Combine

@MainActor
final class MainViewCoordinator: ObservableObject {
    
    @Published public var selectedTab: MainViewTabs = .current
    
}

// MARK: - Extension with public methods

extension MainViewCoordinator {
    
    @ViewBuilder
    public func start() -> some View {
        let viewModel = MainViewModel(coordinator: self)
        MainView(viewModel: viewModel)
    }
    
    @ViewBuilder
    public func showWeatherView() -> some View {
        let coordinator = WeatherViewCoordinator()
        
        coordinator.start()
    }
    
    @ViewBuilder
    public func showListView() -> some View {
        VStack {
            Color.orange
        }
    }
    
}
