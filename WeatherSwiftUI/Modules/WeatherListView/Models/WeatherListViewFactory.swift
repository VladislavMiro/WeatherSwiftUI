import SwiftUI

@MainActor
final class WeatherListViewFactory {
    
    func createWeatherView(data: WeatherResponse) -> some View {
        let factory = WeatherViewFactory()
        
        return factory.createWeatherView(data: data)
    }
    
    func createWeatherListView() -> some View {
        let networkService = NetworkService()
        let storageManager = StorageManger()
        let viewModel = WeatherListViewModel(networkService: networkService, storageManager: storageManager)
        let view = WeatherListView(viewModel: viewModel, factory: self)
        
        return view
    }
    
}
