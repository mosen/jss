import Foundation

/**
 LDAPAccount: Specifies a DN and password for querying an LDAP Server.
*/
class LDAPAccount: NSCoding {
    
    /// The distringuished name of the account used to bind to the LDAP server.
    var distinguishedUsername: String?
    
    /// The SHA-256 hash of the password used to authenticate to the LDAP server.
    var passwordSha256: String?
    
    init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.distinguishedUsername, forKey: "distinguished_username")
        aCoder.encode(self.passwordSha256, forKey: "password_sha256")
    }
}

/**
 LDAPConnection specifies information about a connection to an LDAP Server.
*/
class LDAPConnection: NSCoding {
    
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
    
    init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    convenience init(type: ServerType, hostname: String, bindDN: String) {
        self.init()
        self.serverType = type
        self.hostname = hostname
        
        let acct = LDAPAccount()
        acct.distinguishedUsername = bindDN
        self.account = acct
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.hostname, forKey: "hostname")
        aCoder.encode(self.serverType, forKey: "server_type")
        aCoder.encode(self.port, forKey: "port")
        aCoder.encode(self.useSsl, forKey: "use_ssl")
        aCoder.encode(self.authenticationType, forKey: "authentication_type")
        aCoder.encode(self.account, forKey: "account")
        aCoder.encode(self.openCloseTimeout, forKey: "open_close_timeout")
        aCoder.encode(self.searchTimeout, forKey: "search_timeout")
        aCoder.encode(self.useWildcards, forKey: "use_wildcards")
        aCoder.encode(self.connectionIsUsedFor, forKey: "connection_is_used_for")
    }
}

class LDAPServer: JSSResource {
    var connection: LDAPConnection? = nil
    
}
