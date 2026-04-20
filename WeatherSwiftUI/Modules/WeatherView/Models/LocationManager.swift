//
//  LocationManager.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 16.04.2026.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, LocationManagerProtocol {
    
    // MARK: - Public properties
    
    public var coordinates: AnyPublisher<Coordinates, Never> {
        coordinatesSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Private properties
    
    private let locationManager = CLLocationManager()
    private let defaultCoordinates: Coordinates
    private var coordinatesSubject: PassthroughSubject<Coordinates, Never>
    
    // MARK: - Initializers
    
    override init() {
        self.coordinatesSubject = .init()
        
        self.defaultCoordinates = .init(latitude: 55.7558,
                                        longitude: 37.6178)
        
        super.init()
    
        locationManager.delegate = self
    }
    
}

// MARK: - Extension with LocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { manager.stopUpdatingLocation() }
        
        guard let location = locations.first else { return }
        
        let data = Coordinates(latitude: Float(location.coordinate.latitude),
                               longitude: Float(location.coordinate.longitude))
        
        coordinatesSubject.send(data)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        debugPrint("test", manager.authorizationStatus.rawValue)
        switch manager.authorizationStatus {
        case .restricted, .denied:
            coordinatesSubject.send(defaultCoordinates)
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
}

// MARK: - Extension with public methods

extension LocationManager {
    
    public func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
}
