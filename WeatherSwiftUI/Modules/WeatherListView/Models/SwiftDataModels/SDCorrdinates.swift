import SwiftData
import Foundation

@Model
final class SDCorrdinates: Identifiable {
    var modelID: UUID
    var latitude: Float
    var longitude: Float
    
    init(id: UUID, latitude: Float, longitude: Float) {
        self.modelID = id
        self.latitude = latitude
        self.longitude = longitude
    }
}
