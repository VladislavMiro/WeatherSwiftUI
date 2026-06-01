import SwiftUI

final public class WeatherViewFactory {
    
    func createWeatherView() -> some View {
        let locationManager = LocationManager()
        let networkService = NetworkService()
        let dateFormatter = DateFormatterHelper()
        
        return WeatherView(viewModel: WeatherViewModel(locationManager: locationManager, networkService: networkService, dateFormatter: dateFormatter))
    }
    
    func createDetailWeatherView(data: WeatherResponse) -> some View {
        let viewModel = AirConditionViewModel(data: data)
        
        return DetailWeatherView(viewModel: viewModel)
    }
    
}
