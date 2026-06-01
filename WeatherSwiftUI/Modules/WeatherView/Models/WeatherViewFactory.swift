import SwiftUI

protocol WeatherViewFactoryProtocol: AnyObject {
    associatedtype ContentView: View

    func createWeatherView() -> ContentView
}

final class WeatherViewFactory: WeatherViewFactoryProtocol {
    
    
    func createWeatherView() -> some View {
        let locationManager = LocationManager()
        let networkService = NetworkService()
        
        return WeatherView(viewModel: WeatherViewModel(locationManager: locationManager, networkService: networkService))
    }
}
