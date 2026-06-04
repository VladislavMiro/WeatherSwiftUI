import Foundation
import Combine

protocol WeatherListViewModelProtocol: AnyObject, ObservableObject {
    var state: WeatherListState { get set }
    
    func send(action: WeatherListIntent)
}
