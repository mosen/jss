import Foundation

struct AccountPreferences {
    var language: String?
    var dateFormat: String?
    var region: String?
    var timezone: String?
}

class Account : JSSResource {
    var id: Int = -1
    var name: String? = nil
    var fullName: String? = nil
    var directoryUser: Bool = false
    var email: String? = nil
    var passwordSha256: String? = nil
    var preferences: AccountPreferences? = nil
    // var isMultiSiteAdmin: Bool
    var accessLevel: String? = nil
    var privilegeSet: String? = nil
    //var privileges: Set<ReconPrivileges>? = nil
    var groupIds: [Int]? = []
    var currentSiteId: Int? = nil
    
    override init() {
        super.init()
    }
    
//    static func fromXML(root: XMLElement) -> Account? {
//        do {
//            let idStr = try root.nodes(forXPath: "/account/id").first?.stringValue
//            
//            guard let idStrValue = idStr else {
//                return nil
//            }
//            
//            let intFormatter = NumberFormatter()
//            let id = intFormatter.number(from: idStrValue)
//        
//            let username = try root.nodes(forXPath: "/account/name").first?.stringValue
//            let directoryUser = try root.nodes(forXPath: "/account/directory_user").first?.stringValue
//            let fullName = try root.nodes(forXPath: "/account/full_name").first?.stringValue
//            let email = try root.nodes(forXPath: "/account/email").first?.stringValue
//            let accessLevel = try root.nodes(forXPath: "/account/access_level").first?.stringValue
//            let privilegeSet = try root.nodes(forXPath: "/account/privilege_set").first?.stringValue
//            
//            
//            let account = Account(id: id as Int?, username: username, fullName: fullName, directoryUser: directoryUser == "true", email: email, preferences: nil, accessLevel: accessLevel, privilegeSet: privilegeSet, privileges: nil, groupIds: nil, currentSiteId: nil, passwordHash: nil)
//            return account
//        } catch {
//            return nil
//        }
//    }
    
    class func arrayFromXML(root: XMLElement) -> [Account]? {
        return nil
    }
}

struct AccountGroup {
    var accessLevel: String?
    var privilegeSet: String?
    var siteId: Int?
    var privileges: [String]?
    var memberUserIds: [Int]?
}
