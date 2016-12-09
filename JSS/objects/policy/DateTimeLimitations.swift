import Foundation

class DateTimeLimitations: NSCoding {
    
    enum Days: String {
        case Sun = "Sun"
        case Mon = "Mon"
        case Tue = "Tue"
        case Wed = "Wed"
        case Thu = "Thu"
        case Fri = "Fri"
        case Sat = "Sat"
    }
    
    // Policy activation
    var activationDate: Date?
    var activationDateString: String? {
        get {
            guard let activationDate = self.activationDate else {
                return nil
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: activationDate)
        }
    }
    var activationDateEpoch: Double? {
        get {
            guard let activationDate = self.activationDate else {
                return nil
            }
            
            let epochInterval = activationDate.timeIntervalSince1970
            return epochInterval.rounded()
        }
    }
    var activationDateUtc: String? {
        get {
            guard let activationDate = self.activationDate else {
                return nil
            }
            
            let utcFormatter = DateFormatter()
            utcFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSSZ"
            return utcFormatter.string(from: activationDate)
        }
    }
    
    // Policy Expiration
    var expirationDate: Date?
    var expirationDateString: String? {
        get {
            guard let expirationDate = self.expirationDate else {
                return nil
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: expirationDate)
        }
    }

    var expirationDateEpoch: Double? {
        get {
            guard let expirationDate = self.expirationDate else {
                return nil
            }
            
            let epochInterval = expirationDate.timeIntervalSince1970
            return epochInterval.rounded()
        }
    }

    var expirationDateUtc: String? {
        get {
            guard let expirationDate = self.expirationDate else {
                return nil
            }
            
            let utcFormatter = DateFormatter()
            utcFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSSZ"
            return utcFormatter.string(from: expirationDate)
        }
    }
    
    // array of <day>Sun</day>
    var noExecuteOn: Set<DateTimeLimitations.Days>? = nil
    
    // Time only, 3:03 AM
    var noExecuteStart: Date?
    var noExecuteStartString: String? {
        get {
            guard let noExecuteStart = self.noExecuteStart else {
                return nil
            }
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss"
            
            return timeFormatter.string(from: noExecuteStart)
        }
    }
    
    // Time only, 3:04 AM
    var noExecuteEnd: Date?
    var noExecuteEndString: String? {
        get {
            guard let noExecuteEnd = self.noExecuteEnd else {
                return nil
            }
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss"
            
            return timeFormatter.string(from: noExecuteEnd)
        }
    }
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.activationDateString, forKey: "activation_date")
        aCoder.encode(self.activationDateEpoch, forKey: "activation_date_epoch")
        aCoder.encode(self.activationDateUtc, forKey: "activation_date_utc")
        
        aCoder.encode(self.expirationDateString, forKey: "expiration_date")
        aCoder.encode(self.expirationDateEpoch, forKey: "expiration_date_epoch")
        aCoder.encode(self.expirationDateUtc, forKey: "expiration_date_utc")
        
        aCoder.encode(self.noExecuteOn, forKey:"no_execute_on")
        aCoder.encode(self.noExecuteStartString, forKey:"no_execute_start")
        aCoder.encode(self.noExecuteEndString, forKey:"no_execute_end")
    }
}
