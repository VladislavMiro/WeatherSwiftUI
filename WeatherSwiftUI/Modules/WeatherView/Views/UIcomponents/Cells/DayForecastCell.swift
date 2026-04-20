//
//  DayForecastCell.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI
import RswiftResources

struct DayForecastCell: View {
    
    // MARK: - Private properties
    
    private let data: WeatherViewOutput.DayForecastCell
    
    // MARK: - UI layout
    
    var body: some View {
        VStack(alignment: .center, spacing: LayoutConstants.stackSpacing) {
            Text(data.time)
            
            Image(data.icon)
                .resizable()
                .scaledToFill()
                .frame(width: LayoutConstants.imageSize, height: LayoutConstants.imageSize)
            
            Text(data.temperature)
        }
        .padding()
        .font(Fonts.label)
        .foregroundStyle(Colors.label)
        .background(
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .fill(Colors.background)
        )
    }
    
    // MARK: - Initialaizers
    
    init(data: WeatherViewOutput.DayForecastCell) {
        self.data = data
    }
    
}

// MARK: - Extension with private subobjects

private extension DayForecastCell {
    
    enum LayoutConstants {
        static let itemSize: CGFloat = 115.0
        static let cornerRadius: CGFloat = 15.0
        static let imageSize: CGFloat = 70.0
        static let stackSpacing: CGFloat = 5.0
    }
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
        static let label: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
    }
    
    enum Fonts {
        static let label: Font = .system(size: 14, weight: .bold)
    }
    
}

#Preview {
    DayForecastCell(data: .init(time: "00:00", temperature: "8", icon: "d113"))
}
