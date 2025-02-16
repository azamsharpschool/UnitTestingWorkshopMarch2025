import Foundation

struct APRHistory: Identifiable, Codable {
    var id = UUID()  // Auto-generate unique IDs for SwiftUI use
    let scoreRange: String
    let apr: Double
    let effectiveDate: Date
    
    // Custom decoder to handle date formatting
    enum CodingKeys: String, CodingKey {
        case scoreRange, apr, effectiveDate
    }
    
    init(scoreRange: String, apr: Double, effectiveDate: String) {
        self.scoreRange = scoreRange
        self.apr = apr
        self.effectiveDate = APRHistory.dateFormatter.date(from: effectiveDate) ?? Date()
    }

    // Date Formatter for decoding JSON date strings
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX") // Ensure correct parsing
        return formatter
    }()
    
    // Custom decoding to parse date string into Date object
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.scoreRange = try container.decode(String.self, forKey: .scoreRange)
        self.apr = try container.decode(Double.self, forKey: .apr)
        
        let dateString = try container.decode(String.self, forKey: .effectiveDate)
        self.effectiveDate = APRHistory.dateFormatter.date(from: dateString) ?? Date()
    }
}
