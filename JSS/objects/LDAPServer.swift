import Foundation

/**
 LDAPAccount: Specifies a DN and password for querying an LDAP Server.
*/
public class LDAPAccount: NSCoding {
    
    /// The distringuished name of the account used to bind to the LDAP server.
    public var distinguishedUsername: String?
    
    /// The SHA-256 hash of the password used to authenticate to the LDAP server.
    public var passwordSha256: String?
    
    init() {
        
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.distinguishedUsername, forKey: "distinguished_username")
        aCoder.encode(self.passwordSha256, forKey: "password_sha256")
    }
}

/**
 LDAPConnection specifies information about a connection to an LDAP Server.
*/
public class LDAPConnection: NSCoding {
    
    public enum ServerType: String {
        case ActiveDirectory = "Active Directory"
        case OpenDirectory = "Open Directory"
        case EDirectory = "eDirectory"
        case Custom = "Custom"
    }
    
    public enum AuthenticationType: String {
        case None = "none"
        case Simple = "simple"
        case CRAMMD5 = "CRAM-MD5"
        case DIGESTMD5 = "DIGEST-MD5"
    }
    
    /// Object Identifier
    public var id: Int = 0
    /// The name of the LDAP connection
    public var name: String? = nil
    /// The hostname of the LDAP server
    public var hostname: String? = nil
    /// The type of LDAP server we are connecting to
    public var serverType: LDAPConnection.ServerType? = nil
    /// The port to use (389 for LDAP)
    public var port: Int = 389
    /// Enable SSL connection to the LDAP server
    public var useSsl: Bool = false
    /// The type of authentication to use when querying the LDAP server
    public var authenticationType: LDAPConnection.AuthenticationType? = LDAPConnection.AuthenticationType.None
    /// The credentials to use when binding, including the distinguished name of the account to bind.
    public var account: LDAPAccount? = nil
    /// Amount of time to wait before canceling an attempt to connect to the LDAP server (in seconds).
    public var openCloseTimeout: Int = 15
    /// Amount of time to wait before canceling a search request sent to the LDAP server (in seconds).
    public var searchTimeout: Int = 60
    // referral_response
    /// Use Wildcards When Searching
    var useWildcards: Bool = true
    
    var connectionIsUsedFor: String? = "users"
    
    init() {
        
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
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
    
    public func encode(with aCoder: NSCoder) {
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

/**
 The LDAPServer resource contains information about a connection to an LDAP service, as well
 as the necessary attribute mappings for user and group information.
 */
public class LDAPServer: JSSResource {
    /// Connection information
    public var connection: LDAPConnection? = nil
    
}
