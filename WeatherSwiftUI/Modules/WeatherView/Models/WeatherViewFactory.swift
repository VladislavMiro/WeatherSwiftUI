import SwiftUI

protocol WeatherViewFactoryProtocol: AnyObject {
    associatedtype ContentView: View

    func createWeatherView() -> ContentView
}

final class WeatherViewFactory: WeatherViewFactoryProtocol {
    
    
    func createWeatherView() -> some View {
        let locationManager = LocationManager()
        let networkService = NetworkService()
        let dateFormatter = DateFormatterHelper()
        
        return WeatherView(viewModel: WeatherViewModel(locationManager: locationManager, networkService: networkService, dateFormatter: dateFormatter))
    }
}
