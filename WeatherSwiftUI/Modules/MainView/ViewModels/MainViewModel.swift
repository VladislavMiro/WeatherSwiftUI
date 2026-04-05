//
//  MainViewModel.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 05.04.2026.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    public var coordinator: MainViewCoordinator
    
    // MARK: - Initialaizers
    
    public init(coordinator: MainViewCoordinator) {
        self.coordinator = coordinator
    }
    
}
