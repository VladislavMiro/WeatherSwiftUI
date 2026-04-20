//
//  DayForecastView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI
import RswiftResources

struct DayForecastView: View {
    
    @Binding var data: [WeatherViewOutput.DayForecastCell]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(StringConstants.title)
                .font(Fonts.title)
                .foregroundStyle(Colors.titleText)
                .padding(.top, LayoutConstants.titleTopOffset)
                .padding(.leading, LayoutConstants.titleLeadingOffset)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [
                    .init(.adaptive(minimum: LayoutConstants.rowSize))
                ], spacing: LayoutConstants.rowSpacing) {
                    ForEach(data, id: \.self) { item in
                        DayForecastCell(data: item)
                    }
                }
                .frame(height: LayoutConstants.gridHeight)
                .padding(.horizontal)
            }
        }
        .padding(.bottom)
        .background(
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .fill(Colors.background)
        )
    }
    
}

// MARK: - Extension with private subobjects

private extension DayForecastView {
    
    enum LayoutConstants {
        static let cornerRadius: CGFloat = 15.0
        static let titleTopOffset: CGFloat = 10.0
        static let titleLeadingOffset: CGFloat = 15.0
        static let spacing: CGFloat = 25.0
        static let gridHeight: CGFloat = 150.0
        static let rowSize: CGFloat = 115.0
        static let rowSpacing: CGFloat = 15.0
    }
    
    enum Fonts {
        static let title: Font = .system(size: 16, weight: .bold)
    }
    
    enum Colors {
        static let background: Color = Color(R.color.secondBackgroundColor() ?? .secondarySystemBackground)
        static let titleText: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
    }
    
    enum StringConstants {
        static let title: String = R.string.localizable.dayForecastViewTitle()
    }
    
}

#Preview {
    DayForecastView(data: .constant([]))
}
