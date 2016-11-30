import Foundation

class DistributionPoint : JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/distributionpoints/id/",
        ResourcePaths.FindByName: "/JSSResource/distributionpoints/name/",
        ResourcePaths.FindAll: "/JSSResource/distributionpoints",
        ResourcePaths.CreateById: "/JSSResource/distributionpoints/id/0",
        ResourcePaths.DeleteById: "/JSSResource/distributionpoints/id/",
        ResourcePaths.UpdateById: "/JSSResource/distributionpoints/id/",
    ]
    
    var id: Int = 0
    
    // General
    
    // Display Name
    var name: String? = nil
    // Server
    var ipAddress: String? = nil
    // Use as Master Distribution Point
    var isMaster: Bool = false
    // Name of failover DP
    var failoverPoint: String? = nil
    // Failover DP non-http URL
    var failoverPointUrl: String? = nil
    // Randomized Load Sharing
    var enableLoadBalancing: Bool = false
    
    // File Sharing
    // protocol name clash
    var shareName: String? = nil
    var connectionType: String? = nil // SMB or AFP
    var workgroupOrDomain: String? = nil
    var sharePort: Int = 139
    var readWriteUsername: String? = nil
    var readWritePasswordSha256: String? = nil
    var readOnlyUsername: String? = nil
    var readOnlyPasswordSha256: String? = nil

    // HTTP/HTTPS
    var httpDownloadsEnabled: Bool = false
    var port: Int = 80
    var context: String? = nil
    // Calculated from Use SSL + port + context
    var httpUrl: String? = nil
    
    // HTTP/HTTPS No Auth
    var noAuthenticationRequired: Bool = true
    
    // HTTP/HTTPS Username and Password
    var usernamePasswordRequired: Bool = false
    var httpUsername: String? = nil
    var httpPasswordSha256: String? = nil
    
    // HTTP/HTTPS Client Certificate
    var certificateRequired: Bool = false
    // Certificate name (doesnt include data)
    var certificate: String? = nil
    
    
    // Other
    var localPath: String? = nil
    var sshUsername: String? = nil
    var sshPasswordSha256: String? = nil
    
    // MARK:- NSCoding
    override func encode(with aCoder: NSCoder) {
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
    
    required init() {
        super.init()
        self.rootTag = "distribution_point"
    }
    
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
}
