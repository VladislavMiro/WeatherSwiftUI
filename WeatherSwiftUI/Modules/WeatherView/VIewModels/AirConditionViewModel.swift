import Combine

final class AirConditionViewModel: AirConditionViewModelProtocol, ObservableObject {

    // MARK: - Public properties
    
    public var state: DetailAirConditionState = .init(data: .init())
    
    // MARK: - Initialaizers
    
    public init(data: WeatherResponse) {
        self.state = .init(data: .init())
        self.prepareData(data)
    }
    
}

// MARK: - Extension with private methods

private extension AirConditionViewModel {
    
    func prepareData(_ data: WeatherResponse) {
        let airData = prepareAirData(data)
        let headerData = prepareHeaderData(data)
        
        self.state.data.airCondition = airData
        self.state.data.header = headerData
    }
    
    func prepareHeaderData(_ data: WeatherResponse) -> WeatherViewOutput.Header {
        let icon = (data.current.isDay ? "d" : "n") + data.current.condition.icon
        let temp = String(Int(data.current.temp)) + Symbols.celciusSymbol.description
        
        return .init(regionName: data.location.country, temperature: temp, description: data.current.condition.text, icon: icon)
    }
    
    func prepareAirData(_ data: WeatherResponse) -> [DetailAirConditionOutput.AirConditionCellModel] {
        guard let currWeather = data.forecast.first?.day else { return [] }
        
        let maxTemp = String(Int(currWeather.maxTemp)) + Symbols.celciusSymbol.description
        let minTemp = String(Int(currWeather.minTemp)) + Symbols.celciusSymbol.description
        let chanceOfRain = String(currWeather.chanceOfRain) + Symbols.precent.description
        let chanceOfShow = String(currWeather.chanceOfShow) + Symbols.precent.description
        let uv = String(Int(data.current.uv))
        let wind = String(Int(data.current.wind)) + Symbols.kmPerHour.description
        let visibility = String(Int(data.current.visKm)) + Symbols.km.description
        let hummidity = String(Int(data.current.humidity)) + Symbols.precent.description
        let feelsLike = String(Int(data.current.feelslikeC)) + Symbols.celciusSymbol.description
        let precip = String(Int(data.current.precip)) + Symbols.mm.description
        let pressure = String(Int(data.current.pressure)) + Symbols.hPa.description
        let gust = String(Int(data.current.gust)) + Symbols.kmPerHour.description
        
        var array: [DetailAirConditionOutput.AirConditionCellModel] = []
        
        array.append(.init(label: AirConditionsItems.feelsLike.localizedLabel,
                           icon: AirConditionsItems.feelsLike.imageName,
                           data: feelsLike))
        array.append(.init(label: AirConditionsItems.wind.localizedLabel,
                           icon: AirConditionsItems.wind.imageName,
                           data: wind))
        array.append(.init(label: AirConditionsItems.minTemperature.localizedLabel,
                           icon: AirConditionsItems.minTemperature.imageName,
                           data: minTemp))
        array.append(.init(label: AirConditionsItems.maxTemperatures.localizedLabel,
                           icon: AirConditionsItems.maxTemperatures.imageName,
                           data: maxTemp))
        array.append(.init(label: AirConditionsItems.chanceOfRain.localizedLabel,
                           icon: AirConditionsItems.chanceOfRain.imageName,
                           data: chanceOfRain))
        array.append(.init(label: AirConditionsItems.chanceOfSnow.localizedLabel,
                           icon: AirConditionsItems.chanceOfRain.imageName,
                           data: chanceOfShow))
        array.append(.init(label: AirConditionsItems.hummidity.localizedLabel,
                           icon: AirConditionsItems.hummidity.imageName,
                           data: hummidity))
        array.append(.init(label: AirConditionsItems.visibility.localizedLabel,
                           icon: AirConditionsItems.visibility.imageName,
                           data: visibility))
        array.append(.init(label: AirConditionsItems.precipitation.localizedLabel,
                           icon: AirConditionsItems.precipitation.imageName,
                           data: precip))
        array.append(.init(label: AirConditionsItems.pressure.localizedLabel,
                           icon: AirConditionsItems.pressure.imageName,
                           data: pressure))
        array.append(.init(label: AirConditionsItems.gust.localizedLabel,
                           icon: AirConditionsItems.gust.imageName,
                           data: gust))
        array.append(.init(label: AirConditionsItems.uVIndex.localizedLabel,
                           icon: AirConditionsItems.uVIndex.imageName,
                           data: uv))
        
        return array
    }
    
}
