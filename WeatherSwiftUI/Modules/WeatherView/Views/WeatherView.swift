//
//  WeatherView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI
import RswiftResources

struct WeatherView: View {
    
    // MARK: - Private properties
    
    @StateObject private var viewModel: WeatherViewModel
    @State private var detailIsPresented: Bool = false
    
    // MARK: - UI elements
    
    var body: some View {
        VStack {
            ScrollView {
                WeatherHeaderView()
                
                DayForecastView()
                    .padding(.horizontal)
                
                WeekForecastView()
                    .padding([.top, .horizontal])
                
                AirConditionView {
                    detailIsPresented = true
                }
                .padding()
            }
            .background(Colors.background)
        }
        .alert("Error",
               isPresented: $viewModel.state.isError,
               actions: {
            Button("OK") { }
        }, message: {
            Text(viewModel.state.errorMessage)
        })
        .onAppear {
            viewModel.send(.fetchData)
        }
    }
    
    // MARK: - Initialaizers
    
    public init(viewModel: WeatherViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
}

// MARK: - Extension with private subobjects

private extension WeatherView {
    
    enum LayoutConstants {
        
    }
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
    }
    
}

#Preview {
    let viewModel = WeatherViewModel(coordinator: WeatherViewCoordinator(), locationManager: LocationManager())
    
    WeatherView(viewModel: viewModel)
}
