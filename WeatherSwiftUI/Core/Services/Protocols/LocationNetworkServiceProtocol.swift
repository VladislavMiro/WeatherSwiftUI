import Foundation

protocol LocationNetworkServiceProtocol: AnyObject {
    func fetchLocation(with query: String) async throws -> [Region]
}
