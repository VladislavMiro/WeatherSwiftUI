//
//  WeekForecastView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI

struct WeekForecastView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("")
        }
    }
}

// MARK: - Extension with private subobjects

private extension WeekForecastView {
    
    enum LayoutConstants {
        static let tableViewTopOffset: CGFloat = 15.0
        static let tableViewRowHeight: CGFloat = 54.0
        static let tableViewBottomOffset: CGFloat = 5.0
        static let superViewCornerRadius: CGFloat = 15.0
        static let superViewHeight: CGFloat = 465.0
        static let headerLabelTopOffset: CGFloat = 10.0
        static let headerLabelLeadingOffset: CGFloat = 15.0
    }
    
    enum Fonts {
        static let headerLabel: UIFont = .boldSystemFont(ofSize: 16)
    }
    
    enum StringConstants {
        static let headerLabel: String = R.string.localizable.weekForecastViewTitleLabel()
    }
    
    enum Colors {
        static let background: UIColor? = R.color.secondBackgroundColor()
        static let tableViewBackground: UIColor? = R.color.secondBackgroundColor()
        static let tableViewSeparator: UIColor? = R.color.secondFontColor()
        static let headerLabelText: UIColor? = R.color.secondFontColor()
    }
    
}

#Preview {
    WeekForecastView()
}
