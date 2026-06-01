import Foundation

struct DetailAirConditionOutput {
    var header: WeatherViewOutput.Header
    var airCondition: [AirConditionCellModel]
    
    init(header: WeatherViewOutput.Header, airCondition: [AirConditionCellModel]) {
        self.header = header
        self.airCondition = airCondition
    }
    
    init() {
        self.header = .init()
        self.airCondition = []
    }
    
    struct AirConditionCellModel: Hashable {
        var label: String
        var icon: String
        var data: String
    }
}
