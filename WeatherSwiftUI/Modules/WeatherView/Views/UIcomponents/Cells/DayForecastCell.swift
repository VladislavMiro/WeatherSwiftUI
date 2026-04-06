//
//  DayForecastCell.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI
import RswiftResources

struct DayForecastCell: View {
    var body: some View {
        VStack(alignment: .center, spacing: LayoutConstants.stackSpacing) {
            Text("00:00")
            
            Image(.d119)
                .resizable()
                .scaledToFill()
                .frame(width: LayoutConstants.imageSize, height: LayoutConstants.imageSize)
            
            Text("7")
        }
        //.frame(width: 115, height: 115)
        .padding()
        .font(Fonts.label)
        .foregroundStyle(Colors.label)
        .background(
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .fill(Colors.background)
        )
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
    DayForecastCell()
}
