import Foundation
import Combine

@MainActor
final class WeatherListViewModel {
    
    public typealias NetworkService = LocationNetworkServiceProtocol & WeatherNetworkServiceProtocol
    
    // MARK: - Public properties
    
    @Published public var state: WeatherListState = WeatherListState()

    // MARK: - Private properties
    
    private let networkService: NetworkService
    private let storageManager: StorageManagerProtocol
    private var task: Task<Void, Never>?
    private var cancellables: Set<AnyCancellable> = []
    private var coordinates: [SDCorrdinates] = []
    
    // MARK: - Initialaizers
    
    public init(networkService: NetworkService, storageManager: StorageManagerProtocol) {
        self.networkService = networkService
        self.storageManager = storageManager
        
        bindings()
    }
    
}

// MARK: - Extension with WeatherListViewModelProtocol implementation

extension WeatherListViewModel: WeatherListViewModelProtocol {
    
    public func send(action: WeatherListIntent) {
        switch action {
        case .cancelTasks:
            cancelTasks()
        case .closeAlert:
            closeAlert()
        case .loadRegions:
            loadRegions()
        case .searchModeChanged(let isSearching):
            searchModeChanged(isSearching)
        case .searchTextChanged(let text):
            state.searchText = text
        case .selectRegion(let region):
            self.selectRegion(data: region)
        case .deleteItems(let indexes):
            self.deleteRegion(at: indexes)
        }
    }
    
}

// MARK: - Extension with private properties

private extension WeatherListViewModel {
    
    func search(with query: String) {
        cancelTasks()
        
        guard !query.isEmpty else {
            state.regions = []
            return
        }
        
        task = Task(priority: .userInitiated) {
            do {
                let response = try await networkService.fetchLocation(with: query)
                
                try Task.checkCancellation()
                
                state.regions = response
            } catch let error {
                guard !Task.isCancelled else { return }
                
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func searchModeChanged(_ isSearching: Bool) {
        state.isSearching = isSearching
        
        if !isSearching {
            state.searchText = ""
            state.regions = []
            
            loadRegions()
        }
    }
    
    func searchTextChanged(with text: String) {
        state.searchText = text
    }
    
    func selectRegion(data: Region) {
        saveRegion(data: data)
    }
    
    func saveRegion(data: Region) {
        do {
            let item = SDCorrdinates(latitude: data.lat, longitude: data.lon)
            
            try storageManager.save(data: item)
            
            coordinates.append(item)
            
            fetchWeather(by: [item])
        } catch let error {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func loadRegions() {
        do {
            let coordinates = try storageManager.load(with: nil)
            
            self.fetchWeather(by: coordinates)
        } catch let error {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func deleteRegion(at indexes: IndexSet) {
        do {
            for index in indexes {
                let weather = state.weather[index]
                
                let coordinate = coordinates.first { item in
                    item.id.hashValue == weather.id
                }
                
                guard let coordinate = coordinate else { return }
                
                try storageManager.delete(data: coordinate)
                
                state.weather.remove(at: index)
                coordinates.removeAll { $0.id == coordinate.id }
            }
        } catch let error {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func fetchWeather(by coordinates: [SDCorrdinates]) {
        cancelTasks()
        
        task = Task(priority: .userInitiated) {
            do {
                try await withThrowingTaskGroup { [weak self] group in
                    guard let self = self else { return }
                    
                    for coordinate in coordinates {
                        group.addTask {
                            try Task.checkCancellation()
                            
                            let id = coordinate.id.hashValue
                            let latitudde = coordinate.latitude
                            let longitude = coordinate.longitude
                            
                            let response = try await self.networkService
                                .fetchWeather(by: .init(latitude: latitudde, longitude: longitude))
                            
                            return await self.prepareResponse(id: id, data: response)
                        }
                    }
                    
                    var results: [WeatherListDTO] = []
                    
                    for try await response in group {
                        try Task.checkCancellation()
                        
                        results.append(response)
                    }
                    
                    self.state.weather = results
                }
            } catch let error {
                guard !Task.isCancelled else { return }
                
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func prepareResponse(id: Int, data: WeatherResponse) -> WeatherListDTO {
        let temperature = Int(data.current.temp).description + Symbols.celciusSymbol.description
        let location = data.location.country + ", " + data.location.region
        let icon = (data.current.isDay ? "d" : "n") + data.current.condition.icon
        
        return WeatherListDTO(id: id, temperature: temperature, location: location, icon: icon)
    }
    
    func cancelTasks() {
        guard let task = task else {  return }
        
        task.cancel()
        
        self.task = nil
    }
    
    func showAlert(message: String) {
        state.errorMessage = message
        state.isError = true
    }
    
    func closeAlert() {
        state.isError = false
        state.errorMessage = ""
    }
    
    func bindings() {
        $state
            .map { $0.searchText }
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .eraseToAnyPublisher()
            .sink { [weak self] text in
                self?.search(with: text)
            }
            .store(in: &cancellables)
    }
    
}
