import Foundation

class LDAPAccount: NSCoding {
    var distinguishedUsername: String?
    var passwordSha256: String?
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.distinguishedUsername, forKey: "distinguished_username")
        aCoder.encode(self.passwordSha256, forKey: "password_sha256")
    }
}

class LDAPConnection {
    var id: Int = 0
    var name: String? = nil
    var hostname: String? = nil
    var serverType: String? = nil
    var port: Int = 389
    var useSsl: Bool = false
    var authenticationType: String? = nil
    var account: LDAPAccount? = nil
    var openCloseTimeout: Int = 15
    var searchTimeout: Int = 60
    // referral_response
    var useWildcards: Bool = true
    var connectionIsUsedFor: String? = "users"
}

class LDAPServer: JSSResource {
    var connection: LDAPConnection? = nil
    
}
