
import Foundation

class DateHelper {
    // Extracts the year from a given date string formatted as "yyyy-MM-dd"
    static func extractYear(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Attempt to convert dateString to a Date object
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return "\(year)"
        }
        
        return ""
    }
    
    // Formats a date from "yyyy-MM-dd" to "Month Day, Year" format
    static func formatDate(from dateString: String) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           if let date = dateFormatter.date(from: dateString) {
               let formatter = DateFormatter()
               formatter.dateFormat = "MMMM d, yyyy"
               return formatter.string(from: date)
           }
           return ""
       }
}
