import Foundation



//class PackageConfiguration: NSCoding {
//    var packages: [Package]? = nil
//}
//
//
//

enum NetworkConnection: String {
    case Ethernet = "Ethernet"
}

class NetworkLimitations: NSCoding {
    var minimumNetworkConnection: NetworkConnection? = nil
    var anyIpAddress: Bool = true
    // networkSegments
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.minimumNetworkConnection, forKey: "minimum_network_connection")
        aCoder.encode(self.anyIpAddress, forKey: "any_ip_address")
        // network_segments
    }
}

/// Event(s) to use to trigger the policy
enum PolicyTrigger {
    case Startup
    case Login
    case Logout
    case NetworkStateChange
    case EnrollmentComplete
    case RecurringCheckIn
    case Custom(String)
}

/// Frequency at which to run the policy
enum PolicyExecutionFrequency: String {
    case OncePerComputer = "Once per computer"
    case OncePerUserPerComputer = "Once per user per computer"
    case OncePerUser = "Once per user"
    case OnceEveryDay = "Once every day"
    case OnceEveryWeek = "Once every week"
    case OnceEveryMonth = "Once every month"
    case Ongoing = "Ongoing"
}

class PolicyGeneral: NSCoding {
    
    var id: Int = 0
    var name: String? = nil
    var enabled: Bool = false
    
    // var triggers: Set<PolicyTrigger>
    
    var triggerCheckin: Bool = false
    var triggerEnrollmentComplete: Bool = false
    var triggerLogin: Bool = false
    var triggerLogout: Bool = false
    var triggerNetworkStateChanged: Bool = false
    var triggerStartup: Bool = false
    var triggerOther: Bool = false
    var trigger: String? = nil
    
    var frequency: PolicyExecutionFrequency? = nil
    var locationUserOnly: Bool = false
    var targetDrive: String? = nil
    var offline: Bool = false // Make policy available offline
    var category: Category? = nil
    //var dateTimeLimitations: DateTimeLimitations? = nil
    var networkLimitations: NetworkLimitations? = nil
    var site: Site? = nil
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.enabled, forKey: "enabled")
        aCoder.encode(self.trigger, forKey: "trigger")
        aCoder.encode(self.triggerCheckin, forKey: "trigger_checkin")
        aCoder.encode(self.triggerEnrollmentComplete, forKey: "trigger_enrollment_complete")
        aCoder.encode(self.triggerLogin, forKey: "trigger_login")
        aCoder.encode(self.triggerLogout, forKey: "trigger_logout")
        aCoder.encode(self.triggerNetworkStateChanged, forKey: "trigger_network_state_changed")
        aCoder.encode(self.triggerStartup, forKey: "trigger_startup")
        aCoder.encode(self.frequency, forKey: "frequency")
        aCoder.encode(self.locationUserOnly, forKey: "location_user_only")
        aCoder.encode(self.targetDrive, forKey: "target_drive")
        aCoder.encode(self.offline, forKey: "offline")
        
        if let cat = self.category {
            aCoder.encode(cat, forKey: "category")
        } else {
            let noneCategory = Category.None
            aCoder.encode(noneCategory, forKey: "category")
        }
        
        aCoder.encode(self.site, forKey: "site")
    }
}
//
//
class Policy: JSSResource {

    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/policies/id/",
        ResourcePaths.FindByName: "/JSSResource/policies/name/",
        ResourcePaths.FindAll: "/JSSResource/policies",
        ResourcePaths.CreateById: "/JSSResource/policies/id/0",
        ResourcePaths.UpdateById: "/JSSResource/policies/id/",
        ResourcePaths.DeleteById: "/JSSResource/policies/id/",
        ResourcePaths.FindByCategory: "/JSSResource/policies/category/"
    ]
    
    var general: PolicyGeneral? = nil
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.general, forKey: "general")
    }
}
