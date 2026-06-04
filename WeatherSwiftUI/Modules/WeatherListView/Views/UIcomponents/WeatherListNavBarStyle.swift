import SwiftUI
import RswiftResources

struct WeatherListNavBarStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Colors.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.large)
        
    }
    
}

// MARK: - Extension with private subobjects

private extension WeatherListNavBarStyle {
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .secondarySystemBackground)
    }
    
}
