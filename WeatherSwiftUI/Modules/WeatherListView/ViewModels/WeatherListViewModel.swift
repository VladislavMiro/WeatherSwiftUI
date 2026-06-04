import Foundation
import Combine

final class WeatherListViewModel {
    
    // MARK: - Public properties
    
    @Published public var state: WeatherListState = WeatherListState()

    // MARK: - Private properties
    
    var cancellable: Set<AnyCancellable> = []
    
    // MARK: - Initialaizers
    
    init() {
        $state.sink { data in
            debugPrint(data.selectedRegion)
        }
        .store(in: &cancellable)
    }
    
}

// MARK: - Extension with WeatherListViewModelProtocol implementation

extension WeatherListViewModel: WeatherListViewModelProtocol {
    
    public func send(action: WeatherListIntent) {
        switch action {
        case .search(let query):
            search(with: query)
        }
    }
    
}

// MARK: - Extension with private properties

private extension WeatherListViewModel {
    
    func search(with query: String) {
        
    }
    
}
