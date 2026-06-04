import Foundation
import Combine

final class WeatherListViewModel {
    
    // MARK: - Public properties
    
    @Published public var state: WeatherListState = WeatherListState()

    // MARK: - Private properties
    
    private let networkService: LocationNetworkServiceProtocol
    private var task: Task<Void, Never>?
    
    // MARK: - Initialaizers
    
    public init(networkService: LocationNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}

// MARK: - Extension with WeatherListViewModelProtocol implementation

extension WeatherListViewModel: WeatherListViewModelProtocol {
    
    public func send(action: WeatherListIntent) {
        switch action {
        case .search(let query):
            search(with: query)
        case .cancelTasks:
            cancelTasks()
        case .closeAlert:
            closeAlert()
        }
    }
    
}

// MARK: - Extension with private properties

private extension WeatherListViewModel {
    
    func search(with query: String) {
        if query.isEmpty {
            state.regions = []
            cancelTasks()
        }
        
        cancelTasks()
        
        task = Task(priority: .userInitiated) {
            do {
                let response = try await networkService.fetchLocation(with: query)
                
                guard let task = task, !task.isCancelled else { return }
                
                state.regions = response
            } catch let error {
                state.errorMessage = error.localizedDescription
                state.isError = true
            }
        }
    }
    
    func cancelTasks() {
        guard let task = task else {  return }
        
        task.cancel()
        
        self.task = nil
    }
    
    func closeAlert() {
        state.isError = false
        state.errorMessage = ""
    }
    
}
