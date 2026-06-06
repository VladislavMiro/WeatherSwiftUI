import Foundation

protocol StorageManagerProtocol: AnyObject {
    func save(data: SDCorrdinates) throws
    func delete(data: SDCorrdinates) throws
    func load(with predicate: Predicate<SDCorrdinates>?) throws -> [SDCorrdinates]
}
