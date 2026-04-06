//
//  WeekForecastView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI
import RswiftResources

struct WeekForecastView: View {
    
    private var data: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(StringConstants.title)
                .font(Fonts.title)
                .foregroundStyle(Colors.title)
            List(data, id: \.self) { item in
                WeekForecastCell(day: item)
                    .listRowSeparatorTint(Colors.listSeparator)
                    .listRowBackground(Colors.background)
                    .listRowInsets(.init(.zero))
            }
            .frame(height: LayoutConstants.listHeight)
            .padding(.bottom)
            .scrollDisabled(true)
            .listStyle(.plain)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .fill(Colors.background)
        )
    }
}

// MARK: - Extension with private subobjects

private extension WeekForecastView {
    
    enum LayoutConstants {
        static let cornerRadius: CGFloat = 15.0
        static let listHeight: CGFloat = 300.0
    }
    
    enum Fonts {
        static let title: Font = .system(size: 16, weight: .bold)
    }
    
    enum StringConstants {
        static let title: String = R.string.localizable.weekForecastViewTitle()
    }
    
    enum Colors {
        static let background: Color = Color(R.color.secondBackgroundColor() ?? .secondarySystemBackground)
        static let listSeparator: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let title: Color = Color(R.color.secondFontColor() ?? .secondaryLabel)
    }
    
}

#Preview {
    WeekForecastView()
}
