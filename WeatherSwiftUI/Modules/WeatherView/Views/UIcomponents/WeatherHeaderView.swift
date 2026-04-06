//
//  WeatherHeaderView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI
import RswiftResources

struct WeatherHeaderView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: LayoutConstants.spacing) {
            VStack(alignment: .center) {
                Text("London")
                    .font(Fonts.cityLabel)
                    .foregroundStyle(Colors.cityLabelText)
                Text("Cloudy")
                    .font(Fonts.descriptionLabel)
                    .foregroundStyle(Colors.descriptionLabelText)
            }
            
            Image(.d113)
                .resizable()
                .frame(width: LayoutConstants.imageSize, height: LayoutConstants.imageSize)
                .scaledToFill()
            
            Text("-7")
                .font(Fonts.temperatureLabel)
                .foregroundStyle(Colors.temperatureLabelText)
        }
        .frame(maxWidth: LayoutConstants.width)
        .background(Colors.background)
    }
}

// MARK: - Extension with private subobjects

private extension WeatherHeaderView {
    
    enum LayoutConstants {
        static let width: CGFloat = .infinity
        static let imageSize: CGFloat = 128.0
        static let spacing: CGFloat = 25.0
    }
    
    enum Fonts {
        static let cityLabel: Font = .system(size: 34, weight: .bold)
        static let descriptionLabel: Font = .system(size: 14, weight: .medium)
        static let temperatureLabel: Font = .system(size: 64, weight: .bold)
    }
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
        static let cityLabelText: Color = Color(R.color.fontColor() ?? .white)
        static let descriptionLabelText: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let temperatureLabelText: Color = Color(R.color.fontColor() ?? .white)
    }
    
}

#Preview {
    WeatherHeaderView()
}
