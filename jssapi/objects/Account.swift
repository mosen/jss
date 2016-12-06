import Foundation

/**
 Contains information about JSS User Preferences
 */
public class AccountPreferences: NSCoding {
    public var language: String?
    public var dateFormat: String?
    public var region: String?
    public var timezone: String?
    
    init() {
        
    }
    
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    public func encode(with aCoder: NSCoder) {
    
    }
}

/**
 Contains information about a JSS User account.
 */
public class Account : JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/accounts/id/",
        ResourcePaths.FindByName: "/JSSResource/accounts/name/",
        ResourcePaths.FindAll: "/JSSResource/accounts"
    ]
    
    /// The object identifier, should be zero if creating a new entry.
    public var id: Int = -1
    
    /// The account username which should be unique.
    public var name: String? = nil
    
    /// Full name
    public var fullName: String? = nil
    
    /// Is this user directory based?
    public var directoryUser: Bool = false
    
    /// E-mail address
    public var email: String? = nil
    
    /// SHA-256 hash of the password
    public var passwordSha256: String? = nil
    
    var preferences: AccountPreferences? = nil
    // var isMultiSiteAdmin: Bool
    var accessLevel: String? = nil
    var privilegeSet: String? = nil
    //var privileges: Set<ReconPrivileges>? = nil
    
    /// An array of the group id's that this user is a member of
    public var groupIds: [Int]? = []
    var currentSiteId: Int? = nil
    
    required public init() {
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


// MARK:- Privileges
extension Account {
    public static let privileges : Dictionary<CRUDPrivilege,String> = [
        .Create: "Create Accounts",
        .Read: "Read Accounts",
        .Update: "Update Accounts",
        .Delete: "Delete Accounts",
        ]
}
