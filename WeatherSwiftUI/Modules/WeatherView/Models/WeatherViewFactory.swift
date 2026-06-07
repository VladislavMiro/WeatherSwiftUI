import SwiftUI

final public class WeatherViewFactory {
    
    func createWeatherView(data: WeatherResponse? = nil) -> some View {
        let locationManager = LocationManager()
        let networkService = NetworkService()
        let dateFormatter = DateFormatterHelper()
        
        if let data = data {
            let viewModel = WeatherViewModel(data: data, networkService: networkService, dateFormatter: dateFormatter)
            
            return WeatherView(viewModel: viewModel)
        } else {
            let viewModel = WeatherViewModel(locationManager: locationManager, networkService: networkService, dateFormatter: dateFormatter)
            
            return WeatherView(viewModel: viewModel)
        }
    }
    
    func createDetailWeatherView(data: WeatherResponse) -> some View {
        let viewModel = AirConditionViewModel(data: data)
        
        return DetailWeatherView(viewModel: viewModel)
    }
    
}
