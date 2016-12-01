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
    
    enum ServerType: String {
        case ActiveDirectory = "Active Directory"
        case OpenDirectory = "Open Directory"
        case EDirectory = "eDirectory"
        case Custom = "Custom"
    }
    
    enum AuthenticationType: String {
        case None = "none"
        case Simple = "simple"
        case CRAMMD5 = "CRAM-MD5"
        case DIGESTMD5 = "DIGEST-MD5"
    }
    
    var id: Int = 0
    var name: String? = nil
    var hostname: String? = nil
    var serverType: LDAPConnection.ServerType? = nil
    var port: Int = 389
    var useSsl: Bool = false
    var authenticationType: LDAPConnection.AuthenticationType? = LDAPConnection.AuthenticationType.None
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
