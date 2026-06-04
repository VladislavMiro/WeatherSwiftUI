import Foundation

struct WeatherListState {
    var selectedRegion: Region?
    var regions: [Region] = []
    var isError: Bool = false
    var errorMessage: String = ""
}
