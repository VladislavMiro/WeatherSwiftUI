import Foundation

enum WeatherListIntent {
    case cancelTasks
    case closeAlert
    case loadRegions
    case searchModeChanged(Bool)
    case searchTextChanged(String)
    case selectRegion(Region)
    case selectItem(WeatherListDTO)
    case deleteItems(IndexSet)
}
