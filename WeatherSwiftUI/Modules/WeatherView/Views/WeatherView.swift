//
//  WeatherView.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 06.04.2026.
//

import SwiftUI
import RswiftResources

struct WeatherView: View {
    var body: some View {
        VStack {
            WeatherHeaderView()
        }
        .background(Color.background)
    }
}

// MARK: - Extension with private subobjects

private extension WeatherView {
    
    enum LayoutConstants {
        
    }
    
    enum Colors {
        static let background: Color = Color(R.color.backgroundColor() ?? .systemBackground)
    }
    
}

#Preview {
    WeatherView()
}
