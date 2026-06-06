import Foundation

struct WeatherListState {
    var searchText: String = ""
    var isSearching: Bool = false
    
    var selectedRegion: Region?
    var regions: [Region] = []
    var weather: [WeatherListDTO] = []

    var isError: Bool = false
    var errorMessage: String = ""
}
