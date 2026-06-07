import Foundation

struct WeatherListDTO: Identifiable {
    var id: UUID
    var temperature: String
    var location: String
    var icon: String
}
