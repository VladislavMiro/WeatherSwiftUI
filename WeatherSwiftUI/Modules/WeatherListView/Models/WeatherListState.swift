import Foundation

struct WeatherListState {
    var selectedRegion: Region?
    var regions: [Region] = [
        .init(name: "1", region: "test", country: "test", lat: 0.00, lon: 0.00),
        .init(name: "1", region: "test", country: "test", lat: 0.00, lon: 0.00),
        .init(name: "1", region: "test", country: "test", lat: 0.00, lon: 0.00)
    ]
    var isError: Bool = false
    var errorMessage: String?
}
