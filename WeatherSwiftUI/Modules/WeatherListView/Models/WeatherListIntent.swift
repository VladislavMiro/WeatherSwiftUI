import Foundation

enum WeatherListIntent {
    case search(query: String)
    case cancelTasks
    case closeAlert
}
