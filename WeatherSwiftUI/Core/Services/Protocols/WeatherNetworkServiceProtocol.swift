import Foundation

protocol WeatherNetworkServiceProtocol: AnyObject {
    func fetchWeather(by coord: Coordinates) async throws -> WeatherResponse
}
