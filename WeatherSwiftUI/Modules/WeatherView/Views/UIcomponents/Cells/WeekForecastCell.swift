//
//  WeekForecastCell.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI
import RswiftResources

struct WeekForecastCell: View {
    
    // MARK: - Private properties
    
    private let data: WeatherViewOutput.WeekForecast
    
    // MARK: - UI layout
    
    var body: some View {
        HStack(alignment: .center, spacing: LayoutConstants.stackSpacing) {
            Text(data.day)
                .frame(width: LayoutConstants.dayLabelWidth, alignment: .leading)
            
            HStack(alignment: .center, spacing: LayoutConstants.imageStackSpacing) {
                Image(data.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: LayoutConstants.imageSize, height: LayoutConstants.imageSize)
                Text(data.condition)
                    .frame(alignment: .leading)
            }
            
            Spacer()
            
            Text(data.temperature)
                .frame(alignment: .trailing)
        }
        .foregroundStyle(Colors.labels)
        .font(Fonts.labels)
        .background(Colors.background)
    }
    
    // MARK: - Initialaizers
    
    public init(data: WeatherViewOutput.WeekForecast) {
        self.data = data
    }
    
}

// MARK: - Extension with private subobjects

private extension WeekForecastCell {
    
    enum LayoutConstants {
        static let dayLabelWidth: CGFloat = 80.0
        static let imageSize: CGFloat = 32.0
        static let imageStackSpacing: CGFloat = 5.0
        static let stackSpacing: CGFloat = 5.0
    }
    
    enum Fonts {
        static let labels: Font = .system(size: 14)
    }
    
    enum Colors {
        static let background: Color = Color(R.color.secondBackgroundColor() ?? .secondarySystemBackground)
        static let labels: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
    }
    
}

#Preview {
    WeekForecastCell(data: .init(day: "Monday", icon: "d113", condition: "Cloudy", temperature: "0"))
}
