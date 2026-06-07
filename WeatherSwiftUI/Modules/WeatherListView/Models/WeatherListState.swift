import Foundation

struct WeatherListState {
    var searchText: String = ""
    var isSearching: Bool = false
    var isDetailShow: Bool = false
    
    var selectedItem: WeatherResponse?
    var regions: [Region] = []
    var weather: [WeatherListDTO] = []

    var isError: Bool = false
    var errorMessage: String = ""
}
