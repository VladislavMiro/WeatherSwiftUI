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
    @State private var path: NavigationPath = NavigationPath()
    
    // MARK: - UI elements
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                WeatherHeaderView(data: $viewModel.state.data.header)
                
                DayForecastView(data: $viewModel.state.data.dayForecast)
                    .padding(.horizontal)
                
                WeekForecastView(data: $viewModel.state.data.weekForecast)
                    .padding([.top, .horizontal])
                
                AirConditionView(data: $viewModel.state.data.airCondition, isButtonTapped: $detailIsPresented)
                    .padding()
            }
            .navigationDestination(isPresented: $detailIsPresented) {
                Color.green
            }
            .background(Colors.background)
            .refreshable {
                viewModel.send(.fetchData)
            }
        }
        .alert(StringConstants.errorTitle, isPresented: $viewModel.state.isError, actions: {
            Button(StringConstants.alertOkButton) {
                viewModel.state.isError = false
            }
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
       self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
}

// MARK: - Extension with private subobjects

private extension WeatherView {
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
    }
    
    enum StringConstants {
        static let errorTitle: String = R.string.localizable.weatherViewErrorTitle()
        static let alertOkButton: String = R.string.localizable.weatherViewAlertOkButton()
    }
    
}

#Preview {
    let viewModel = WeatherViewModel(locationManager: LocationManager(), networkService: NetworkService(), dateFormatter: DateFormatterHelper())
    
    WeatherView(viewModel: viewModel)
}
