//
//  WeatherViewModel.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 16.04.2026.
//

import Foundation
import CoreLocation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published public var state: WeatherViewState = .init()
    
    // MARK: - Private properties
    
    private let locationManager: LocationManagerProtocol?
    private let networkService: WeatherNetworkServiceProtocol
    private var task: Task<Void, Never>?
    private var cancelable: Set<AnyCancellable> = []
    
    // MARK: - initialaizers
    
    public init(locationManager: LocationManagerProtocol, networkService: WeatherNetworkServiceProtocol) {
        self.locationManager = locationManager
        self.networkService = networkService
        debugPrint("Init")
        bind()
    }
    
}

// MARK: - Extension with WeatherViewModelProtocol implementations

extension WeatherViewModel: WeatherViewModelProtocol {
    
    public func send(_ intent: WeatherViewIntent) {
        switch intent {
        case .fetchData:
            fetchData()
        case .cancelTask:
            cancelTask()
        }
    }
    
}

// MARK: - Extension with private methods

private extension WeatherViewModel {
    
    func fetchLocation() {
        if let locationManager = locationManager {
            locationManager.getCurrentLocation()
        } else {
            fetchData()
        }
    }
    
    func fetchData() {
        if let coordinates = state.coordinates {
            fetchWeather(coordinates: coordinates)
        } else {
            locationManager?.getCurrentLocation()
        }
    }
    
    func bind() {
        locationManager?.coordinates.sink { [weak self] coordinates in
            self?.state.coordinates = coordinates
            self?.fetchWeather(coordinates: coordinates)
        }
        .store(in: &cancelable)
    }
    
    func fetchWeather(coordinates: Coordinates) {
        state.isError = false
        state.isRefreshing = true
        
        cancelTask()
        
        debugPrint("fetchData")
        
        task = Task(priority: .userInitiated) {
            do {
                let data = try await networkService.fetchWeather(by: coordinates)
                
                debugPrint(data)
                
                state.isRefreshing = false
                prepareData(data: data)
            } catch let error {
                guard let task = task, !task.isCancelled else { return }
                
                state.errorMessage = error.localizedDescription
                state.isError = true
                state.isRefreshing = false
            }
        }
        
    }
    
    func cancelTask() {
        task?.cancel()
        task = nil
    }
    
    func prepareData(data: WeatherResponse) {
        let header = prepareHeaderData(data: data)
        let dayForecast = prepareDayForecast(data: data.forecast.first?.hour ?? [])
        let weekForecast = prepareWeekForecast(data: data.forecast)
        let airConditions = prepareAirCondition(data: data)
        
        state.data = .init(header: header, dayForecast: dayForecast, weekForecast: weekForecast, airCondition: airConditions)
    }
    
    func prepareHeaderData(data: WeatherResponse) -> WeatherViewOutput.Header {
        let icon = (data.current.isDay ? "d" : "n") + data.current.condition.icon
        
        return .init(regionName: data.location.country,
                     temperature: String(Int(data.current.temp)) + Symbols.celciusSymbol.description,
                     description: data.current.condition.text,
                     icon: icon
        )
    }
    
    func prepareDayForecast(data: [DailyForecast]) -> [WeatherViewOutput.DayForecastCell] {
        return data.map { item in
            let icon = (item.isDay ? "d" : "n") + item.condition.icon
            
            return WeatherViewOutput.DayForecastCell(time: convertDate(date: item.time) ?? "00:00", temperature: String(Int(item.temp)) + Symbols.celciusSymbol.description,
                                                     icon: icon)
        }
    }
    
    func prepareWeekForecast(data: [Forecast]) -> [WeatherViewOutput.WeekForecast] {
        return data.map { item in
            let icon = "d" + item.day.condition.icon
            let temp = String(Int(item.day.minTemp)) + "/" + String(Int(item.day.maxTemp))
            
            return .init(day: formateDay(day: item.date) ?? "---",
                         icon: icon,
                         condition: item.day.condition.text,
                         temperature: temp)
        }
    }
    
    func prepareAirCondition(data: WeatherResponse) -> WeatherViewOutput.AirCondition {
        let day: Int = data.forecast.first?.day.chanceOfRain ?? 0
        let chanceOfRain = String(day) + Symbols.precent.description
        let wind = String(Int(data.current.wind)) + Symbols.kmPerHour.description
        let realFeel = String(Int(data.current.feelslikeC)) + Symbols.celciusSymbol.description
        let uvIndex = String(Int(data.current.uv))
        
        return .init(wind: wind,
                     chanceOfRain: chanceOfRain,
                     realFeel: realFeel,
                     uvIndex: uvIndex)
    }
    
    func convertDate(date: String) -> String? {
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = formatter.date(from: date) else { return nil }
        
        formatter.dateFormat = "HH:mm"
       
        return formatter.string(from: date)
    }
    
    func formateDay(day: String) -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: day)
        
        guard let date = date else { return nil }
        
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date)
    }
    
}
