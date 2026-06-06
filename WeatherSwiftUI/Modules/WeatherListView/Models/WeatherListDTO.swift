import Foundation

struct WeatherListDTO: Identifiable {
    var id: Int
    var temperature: String
    var location: String
    var icon: String
}
