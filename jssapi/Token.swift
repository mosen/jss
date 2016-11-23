import Foundation

struct Token {
    let value: String
    let expires: Date
    
    func expired() -> Bool {
        let now = Date()
        return now.compare(self.expires) == .orderedAscending
    }
    
    static func fromJSONObject(json: [String:AnyObject]) -> Token? {
        guard
            let value = json["token"] as? String,
            let expiresDateString = json["expires"] as? String else {
                return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // Should be timestamp unix time
        
        guard let expiresDate = formatter.date(from: expiresDateString) else {
            return nil
        }
        
        return Token(value: value, expires: expiresDate)
    }
}
