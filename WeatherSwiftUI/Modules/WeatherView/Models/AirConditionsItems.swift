import Foundation
import RswiftResources

enum AirConditionsItems {
    case feelsLike
    case wind
    case minTemperature
    case maxTemperatures
    case chanceOfRain
    case chanceOfSnow
    case hummidity
    case visibility
    case precipitation
    case pressure
    case gust
    case uVIndex
    
    var localizedLabel: String {
        switch self {
        case .feelsLike:
            R.string.localizable.airConditionsItemFeelsLike()
        case .wind:
            R.string.localizable.airConditionsItemWind()
        case .minTemperature:
            R.string.localizable.airConditionsItemMinTemperature()
        case .maxTemperatures:
            R.string.localizable.airConditionsItemMaxTemperature()
        case .chanceOfRain:
            R.string.localizable.airConditionsItemChanceOfRain()
        case .chanceOfSnow:
            R.string.localizable.airConditionsItemChanceOfSnow()
        case .hummidity:
            R.string.localizable.airConditionsItemHummidity()
        case .visibility:
            R.string.localizable.airConditionsItemVisibility()
        case .precipitation:
            R.string.localizable.airConditionsItemPrecipitation()
        case .pressure:
            R.string.localizable.airConditionsItemPressure()
        case .gust:
            R.string.localizable.airConditionsItemGust()
        case .uVIndex:
            R.string.localizable.airConditionsItemUVIndex()
        }
    }
    
    var imageName: String {
        switch self {
        case .feelsLike: "thermometer.medium"
        case .wind: "wind"
        case .minTemperature: "thermometer.low"
        case .maxTemperatures: "thermometer.high"
        case .chanceOfRain: "cloud.rain"
        case .chanceOfSnow: "cloud.snow"
        case .hummidity: "humidity"
        case .visibility: "eye"
        case .precipitation: "cloud.drizzle.fill"
        case .pressure: "cloud.circle"
        case .gust: "aqi.medium"
        case .uVIndex: "sun.max.fill"
        }
        
    }
}
