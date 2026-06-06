import SwiftUI

@MainActor
final class WeatherListViewFactory {
    
    func createWeatherListView() -> some View {
        let networkService = NetworkService()
        let storageManager = StorageManger()
        let viewModel = WeatherListViewModel(networkService: networkService, storageManager: storageManager)
        let view = WeatherListView(viewModel: viewModel)
        
        return view
    }
    
}
