import Foundation

/**
 DistributionPoint contains connection information for a (non-cloud) distribution point.
 */
public class DistributionPoint : JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/distributionpoints/id/",
        ResourcePaths.FindByName: "/JSSResource/distributionpoints/name/",
        ResourcePaths.FindAll: "/JSSResource/distributionpoints",
        ResourcePaths.CreateById: "/JSSResource/distributionpoints/id/0",
        ResourcePaths.DeleteById: "/JSSResource/distributionpoints/id/",
        ResourcePaths.UpdateById: "/JSSResource/distributionpoints/id/",
    ]
    
    /// Object Identifier
    public var id: Int = 0
    
    // General
    
    /// Display Name
    public var name: String? = nil
    /// Server host or IP Address
    public var ipAddress: String? = nil
    /// Use as Master Distribution Point
    public var isMaster: Bool = false
    /// Name of failover distribution point
    public var failoverPoint: String? = nil
    /// Failover DP non-http URL
    public var failoverPointUrl: String? = nil
    /// Randomized Load Sharing
    public var enableLoadBalancing: Bool = false
    
    // File Sharing
    // protocol name clash
    
    /// Name of the file share to connect to.
    public var shareName: String? = nil
    
    /// Type of file sharing connection, "SMB" or "AFP".
    public var connectionType: String? = nil
    /// SMB workgroup or domain name (if applicable)
    public var workgroupOrDomain: String? = nil
    /// File sharing TCP port (139 for SMB, 548 for AFP)
    public var sharePort: Int = 139
    
    /// The read/write account username
    public var readWriteUsername: String? = nil
    /// The read/write account password SHA-256 hash
    public var readWritePasswordSha256: String? = nil
    /// The read only account username
    public var readOnlyUsername: String? = nil
    /// The read only account password SHA-256 hash
    public var readOnlyPasswordSha256: String? = nil

    /// Enable HTTP/HTTPS downloads from this distribution point
    public var httpDownloadsEnabled: Bool = false
    
    /// The HTTP(S) port to use
    public var port: Int = 80
    /// The relative path to the share
    public var context: String? = nil
    // Calculated from Use SSL + port + context
    var httpUrl: String? = nil
    
    /// No authentication is required for HTTP(S) connections.
    public var noAuthenticationRequired: Bool = true
    
    /// Enable HTTP/HTTPS Username and Password Authentication
    public var usernamePasswordRequired: Bool = false
    
    /// HTTP(S) username
    public var httpUsername: String? = nil
    /// HTTP(S) password SHA-256 hash
    public var httpPasswordSha256: String? = nil
    
    /// Enable HTTP/HTTPS Client Certificate Authentication
    public var certificateRequired: Bool = false
    /// Certificate name (doesnt include data)
    public var certificate: String? = nil
    
    // Other
    var localPath: String? = nil
    var sshUsername: String? = nil
    var sshPasswordSha256: String? = nil
    
    // MARK:- NSCoding
    override public func encode(with aCoder: NSCoder) {
        // General
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.ipAddress, forKey:"ip_address")
        aCoder.encode(self.ipAddress, forKey:"ipAddress")
        aCoder.encode(self.isMaster, forKey:"is_master")
        //aCoder.encode(self.failoverPoint, forKey:"failover_point")
        //aCoder.encode(self.failoverPointUrl, forKey:"failover_point_url")
        //aCoder.encode(self.enableLoadBalancing, forKey:"enable_load_balancing")
        
        // File Sharing
        aCoder.encode(self.shareName, forKey:"share_name")
        aCoder.encode(self.connectionType, forKey:"connection_type")
        aCoder.encode(self.workgroupOrDomain, forKey:"workgroup_or_domain")
        aCoder.encode(self.sharePort, forKey:"share_port")
        aCoder.encode(self.readWriteUsername, forKey:"read_write_username")
        aCoder.encode(self.readWritePasswordSha256, forKey:"read_write_password_sha256")
        aCoder.encode(self.readOnlyUsername, forKey:"read_only_username")
        aCoder.encode(self.readOnlyPasswordSha256, forKey:"read_only_password_sha256")
        
        // HTTP/HTTPS
//        aCoder.encode(self.httpDownloadsEnabled, forKey:"http_downloads_enabled")
//        aCoder.encode(self.port, forKey:"port")
//        aCoder.encode(self.context, forKey:"context")
//        aCoder.encode(self.httpUrl, forKey:"http_url")
//        aCoder.encode(self.noAuthenticationRequired, forKey:"no_authentication_required")
//        aCoder.encode(self.usernamePasswordRequired, forKey:"username_password_required")
//        aCoder.encode(self.httpUsername, forKey:"http_username")
//        aCoder.encode(self.httpPasswordSha256, forKey:"http_password_sha256")
//        aCoder.encode(self.certificateRequired, forKey:"certificate_required")
//        aCoder.encode(self.certificate, forKey:"certificate")
    }
    
    required public init() {
        super.init()
        self.rootTag = "distribution_point"
    }
    
    // Don't care about decoding
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
}
