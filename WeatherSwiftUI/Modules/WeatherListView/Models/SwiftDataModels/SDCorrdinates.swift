import SwiftData
import Foundation

@Model
final class SDCorrdinates {
    var latitude: Float
    var longitude: Float
    
    init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
