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
    
    // MARK: - Initialaizers
    
    public init(apiKey: String) {
        let configuration = URLSessionConfiguration.default
        
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15

        self.session = URLSession(configuration: configuration)
        self.apiKey = apiKey
    }
    
}
