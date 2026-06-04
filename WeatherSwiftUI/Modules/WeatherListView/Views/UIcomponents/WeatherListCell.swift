import SwiftUI
import RswiftResources

struct WeatherListCell: View {
    
    // MARK: - Private properties
    
    private let temperature: String
    private let region: String
    private let icon: String
    
    // MARK: - UI elements
    
    var body: some View {
        HStack(alignment: .center) {
            Group {
                VStack(alignment: .leading) {
                    Text(temperature)
                        .font(Fonts.temperatureLabel)
                    Text(region)
                        .font(Fonts.regionLabel)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Colors.font)
                
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
            }
            .padding(.horizontal, Constants.paddingSpacing)
        }
        .background(Colors.background)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
    
    // MARK: - Initializers
    
    public init(temperature: String, region: String, icon: String) {
        self.temperature = temperature
        self.region = region
        self.icon = icon
    }
    
}

// MARK: - Extension with private subobjects

private extension WeatherListCell {
    
    enum Colors {
        static let background: Color = Color(R.color.secondBackgroundColor() ?? .secondarySystemBackground)
        static let font: Color = Color(R.color.fontColor() ?? .label)
    }
    
    enum Constants {
        static let imageSize: CGFloat = 80.0
        static let cornerRadius: CGFloat = 15.0
        static let paddingSpacing: CGFloat = 15.0
    }
    
    enum Fonts {
        static let temperatureLabel: Font = .system(size: 36.0, weight: .bold)
        static let regionLabel: Font = .system(size: 16.0, weight: .bold)
    }
    
}

#Preview {
    WeatherListCell(temperature: "10", region: "London, Russia", icon: "d113")
}
