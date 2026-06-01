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
    
    @StateObject private var viewModel: WeatherViewModel = WeatherViewModel(locationManager: LocationManager(), networkService: NetworkService())
    @State private var detailIsPresented: Bool = false
    
    // MARK: - UI elements
    
    var body: some View {
        VStack {
            ScrollView {
                WeatherHeaderView(data: $viewModel.state.data.header)
                
                DayForecastView(data: $viewModel.state.data.dayForecast)
                    .padding(.horizontal)
                
                WeekForecastView(data: $viewModel.state.data.weekForecast)
                    .padding([.top, .horizontal])
                
                AirConditionView(data: $viewModel.state.data.airCondition) {
                    detailIsPresented = true
                }
                .padding()
            }
            .background(Colors.background)
            .refreshable {
                viewModel.send(.fetchData)
            }
        }
        .alert("Error", isPresented: $viewModel.state.isError,
               actions: {
            Button("OK") { }
        }, message: {
            Text(viewModel.state.errorMessage)
        })
        .onAppear {
            viewModel.send(.fetchData)
        }
        .onDisappear {
            viewModel.send(.cancelTask)
        }
    }
    
    // MARK: - Initialaizers
    
    public init(viewModel: WeatherViewModel) {
       // self._viewModel = StateObject(wrappedValue: viewModel)
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
    let viewModel = WeatherViewModel(locationManager: LocationManager(), networkService: NetworkService())
    
    WeatherView(viewModel: viewModel)
}
