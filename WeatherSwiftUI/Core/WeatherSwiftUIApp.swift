//
//  WeatherSwiftUIApp.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 05.04.2026.
//

import SwiftUI

@main
struct WeatherSwiftUIApp: App {
    
    @StateObject private var appCoordinator = MainViewCoordinator()
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
        }
    }
}
