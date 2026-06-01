//
//  DetailWeatherView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 01.06.2026.
//

import SwiftUI
import RswiftResources

struct DetailWeatherView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView(.vertical) {
                WeatherHeaderView(data: .constant(.init()))
                
                
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
}

// MARK: - Extension with private methods

private extension DetailWeatherView {

    
}

// MARK: - Extension with private subobjects

private extension DetailWeatherView {
    
    enum StringConstants {
        static let title: String = R.string.localizable.detailWeatherViewTitle()
    }
    
    enum Colors {
        static let background = Color(R.color.backgroundColor() ?? .systemBackground)
        static let navBarTint = Color(R.color.secondFontColor() ?? .secondaryLabel)
        static let navBarBackground = Color(R.color.secondBackgroundColor() ?? .secondarySystemBackground)
    }
    
}

#Preview {
    NavigationStack {
        DetailWeatherView()
    }
}
