import SwiftUI
import RswiftResources

struct WeatherListCellStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(Colors.background)
            .listRowInsets(.init(top: Constants.rowVerticalInsets,
                                 leading: Constants.rowHorizontalInsets,
                                 bottom: Constants.rowVerticalInsets,
                                 trailing: Constants.rowHorizontalInsets)
            )
    }
    
}

// MARK: - Extension with private subobjects

private extension WeatherListCellStyle {
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
    }
    
    enum Constants {
        static let rowVerticalInsets: CGFloat = .zero
        static let rowHorizontalInsets: CGFloat = 20.0
    }
    
}
