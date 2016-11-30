import Foundation


//class Scope: NSCoding {
//    var allComputers: Bool = false
//    
//}

//class PackageConfiguration: NSCoding {
//    var packages: [Package]? = nil
//}
//
//
//class DateTimeLimitations: NSCoding {
//    var activationDate: Date?
//    var activationDateEpoch: Int = 0
//    var activationDateUtc: String?
//    var expirationDate: Date?
//    var expirationDateEpoch: Int = 0
//    var expirationDateUtc: String?
//    var noExecuteOn: Date?
//    var noExecuteStart: Date?
//    var noExecuteEnd: Date?
//    
//}
//
//class NetworkLimitations: NSCoding {
//    var minimumNetworkConnection: String? = nil
//    var anyIpAddress: Bool = true
//    // networkSegments
//}
//
//
//class PolicyGeneralSubset: NSCoding {
//    var id: Int = 0
//    var name: String? = nil
//    var enabled: Bool = false
//    var trigger: String? = nil
//    var triggerCheckin: Bool = false
//    var triggerEnrollmentComplete: Bool = false
//    var triggerLogin: Bool = false
//    var triggerLogout: Bool = false
//    var triggerNetworkStateChanged: Bool = false
//    var triggerStartup: Bool = false
//    //trigger_other
//    var frequency: String? = nil
//    var locationUserOnly: Bool = false
//    var targetDrive: String? = nil
//    var offline: Bool = false
//    var category: Category? = nil
//    var site: Site? = nil
//}
//
//
//class Policy: JSSResource, NSCoding {
//
//    static let resourcePaths : [ResourcePaths:String] = [
//        ResourcePaths.FindById : "/JSSResource/policies/id/",
//        ResourcePaths.FindByName: "/JSSResource/policies/name/",
//        ResourcePaths.FindAll: "/JSSResource/policies",
//        ResourcePaths.CreateById: "/JSSResource/policies/id/0",
//        ResourcePaths.UpdateById: "/JSSResource/policies/id/",
//        ResourcePaths.DeleteById: "/JSSResource/policies/id/",
//        ResourcePaths.FindByCategory: "/JSSResource/policies/category/"
//    ]
//    
//}
