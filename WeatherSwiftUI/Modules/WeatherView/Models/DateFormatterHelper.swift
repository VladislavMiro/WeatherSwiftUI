import Foundation

struct DateFormatterHelper: DateFormatterProtocol {
    
    public func convertDate(date: String) -> String? {
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = formatter.date(from: date) else { return nil }
        
        formatter.dateFormat = "HH:mm"
       
        return formatter.string(from: date)
    }
    
    public func formateDay(day: String) -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: day)
        
        guard let date = date else { return nil }
        
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date)
    }
    
}
