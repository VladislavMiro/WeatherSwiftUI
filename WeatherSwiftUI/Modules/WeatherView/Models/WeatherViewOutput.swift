//
//  WeatherViewOutput.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 20.04.2026.
//

import Foundation

struct WeatherViewOutput {
    
    var header: Header = .init()
    var dayForecast: [DayForecastCell] = []
    var weekForecast: [WeekForecast] = []
    var airCondition: AirCondition = .init()
    
    struct Header {
        var regionName: String = "--"
        var temperature: String = "0" + Symbols.celciusSymbol.description
        var description: String = "---"
        var icon: String = "d119"
    }
    
    struct DayForecastCell: Hashable {
        var time: String
        var temperature: String
        var icon: String
    }
    
    struct WeekForecast {
        var day: String
        var icon: String
        var condition: String
        var temperature: String
    }
    
    struct AirCondition {
        var wind: String = "0" + Symbols.kmPerHour.description
        var chanceOfRain: String = "0" + Symbols.precent.description
        var realFeel: String = "0" + Symbols.celciusSymbol.description
        var uvIndex: String = "0"
    }
    
}
