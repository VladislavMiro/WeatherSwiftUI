import SwiftUI
import RswiftResources

struct DetailWeatherView: View {
    
    // MARK: - Private properties
    
    private let columns: [GridItem] = [
        GridItem(.flexible(minimum: Constants.gridItemMinSize)),
        GridItem(.flexible(minimum: Constants.gridItemMinSize))
    ]
    
    @StateObject private var viewModel: AirConditionViewModel
    
    // MARK: - UI elements
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView(.vertical) {
                WeatherHeaderView(data: $viewModel.state.data.header)
                
                LazyVGrid(columns: columns, alignment: .center, spacing: Constants.gridSpacing) {
                    ForEach(viewModel.state.data.airCondition, id: \.self) { item in
                        AirConditionCell(label: item.label, image: item.icon, data: item.data)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Colors.background)
            .navigationTitle(StringConstants.title)
            .tint(Colors.navBarTint)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Colors.navBarBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    // MARK: - Initialaizers
    
    public init(viewModel: AirConditionViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
}

// MARK: - Extension with private subobjects

private extension DetailWeatherView {
    
    enum StringConstants {
        static let title: String = R.string.localizable.detailWeatherViewTitle()
    }
    
    enum Constants {
        static let gridSpacing: CGFloat = 16.0
        static let gridItemMinSize: CGFloat = 128
    }
    
    enum Colors {
        static let background = Color(R.color.backgroundColor() ?? .systemBackground)
        static let navBarTint = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let navBarBackground = Color(R.color.secondBackgroundColor() ?? .secondarySystemBackground)
    }
    
}
