import Foundation

struct AccountPreferences {
    var language: String?
    var dateFormat: String?
    var region: String?
    var timezone: String?
}

class Account : JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/accounts/id/",
        ResourcePaths.FindByName: "/JSSResource/accounts/name/",
        ResourcePaths.FindAll: "/JSSResource/accounts"
    ]
    
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
    
    required init() {
        super.init()
    }
}

struct AccountGroup {
    var accessLevel: String?
    var privilegeSet: String?
    var siteId: Int?
    var privileges: [String]?
    var memberUserIds: [Int]?
}
