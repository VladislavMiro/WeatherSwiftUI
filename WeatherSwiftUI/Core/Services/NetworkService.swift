//
//  NetworkService.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 20.04.2026.
//

import Foundation

final class NetworkService {
    
    // MARK: - Private properties
    
    private let session: URLSession
    private let apiKey: String
    private let decoder: JSONDecoder
    
    // MARK: - Initialaizers
    
    public init() {
        let configuration = URLSessionConfiguration.default
        
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15

        self.decoder = JSONDecoder()
        self.session = URLSession(configuration: configuration)
        self.apiKey = Bundle.main.infoDictionary?["WeatherApi"] as? String ?? ""
    }
    
}

// MARK: - Extension with WeatherNetworkServiceProtocol implementation

extension NetworkService: WeatherNetworkServiceProtocol {
    
    public func fetchWeather(by coord: Coordinates) async throws -> WeatherResponse {
        guard !apiKey.isEmpty else { throw URLError(.badServerResponse) }
        
        let urlString = String(format: Endpoints.baseURL.rawValue, apiKey, coord.latitude, coord.longitude)
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = HTTPMethods.GET.rawValue
        urlRequest.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try decoder.decode(WeatherResponse.self, from: data)
        
        return decodedData
    }
    
}

// MARK: - Extension with WeatherNetworkServiceProtocol implementation

extension NetworkService: LocationNetworkServiceProtocol {
    
    public func fetchLocation(with query: String) async throws -> [Region] {
        let urlString = String(format: Endpoints.locationURL.rawValue, apiKey, query)
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = HTTPMethods.GET.rawValue
        urlRequest.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try decoder.decode([Region].self, from: data)
        
        return decodedData
    }
    
}

// MARK: - Extension with private subobjects

private extension NetworkService {
    
    enum Endpoints: String {
        case baseURL = "https://api.weatherapi.com/v1/forecast.json?key=%@&q=%f,%f&days=7&aqi=no&alerts=no"
        case locationURL = "https://api.weatherapi.com/v1/search.json?key=%@&q=%@"
    }
    
    enum HTTPMethods: String {
        case GET
        case PUT
        case DELETE
        case UPDATE
        case POST
        case PATCH
    }
    
}
