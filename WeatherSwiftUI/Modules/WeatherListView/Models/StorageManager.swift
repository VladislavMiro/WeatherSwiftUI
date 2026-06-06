import Foundation
import SwiftData

final class StorageManger {
    
    // MARK: - Private properties
    
    private let container: ModelContainer
    private let context: ModelContext
    
    // MARK: - Initialaizers
    
    init() {
        do {
            container = try ModelContainer(for: SDCorrdinates.self)
            context = container.mainContext
        } catch {
            fatalError("Fatal error. Can not create a storage manager.")
        }
    }
    
}

// MARK: - Extension with

extension StorageManger: StorageManagerProtocol {
    
    public func save(data: SDCorrdinates) throws {
        let latitude = data.latitude
        let longitude = data.longitude
        
        let predicate = #Predicate<SDCorrdinates> { item in
            item.latitude == latitude && item.longitude == longitude
        }
        
        let isNotExist = try load(with: predicate).isEmpty
        
        if isNotExist {
            context.insert(data)
            
            try saveContext()
        }
    }
    
    public func delete(data: SDCorrdinates) throws {
        container.mainContext.delete(data)
        
        try saveContext()
    }
    
    public func load(with predicate: Predicate<SDCorrdinates>? = nil) throws -> [SDCorrdinates] {
        var descriptor = FetchDescriptor<SDCorrdinates>()
        
        if let predicate = predicate {
            descriptor.predicate = predicate
        }
        
        let result = try context.fetch(descriptor)
        
        return result
    }
    
}

// MARK: - Extension with private methods

private extension StorageManger {
    
    func saveContext() throws {
        guard context.hasChanges else { return }
        
        try context.save()
    }
    
}
