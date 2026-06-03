import SwiftUI

@MainActor
final class WeatherListViewFactory {
    
    func createWeatherListView() -> some View {
        
        let view = WeatherListView()
        
        return view
    }
    
}
