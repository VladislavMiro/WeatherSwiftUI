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
            ScrollView {
                WeatherHeaderView()
                
                DayForecastView()
                    .padding(.horizontal)
                
                WeekForecastView()
                    .padding([.top, .horizontal])
                
                AirConditionView {
                    debugPrint("Tapped")
                }
                .padding()
            }
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
