import SwiftUI

@MainActor
final class WeatherListViewFactory {
    
    func createWeatherListView() -> some View {
        let networkService = NetworkService()
        let viewModel = WeatherListViewModel(networkService: networkService)
        let view = WeatherListView(viewModel: viewModel)
        
        return view
    }
    
}
