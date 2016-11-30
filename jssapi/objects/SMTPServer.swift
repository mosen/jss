import Foundation

class SMTPServer : JSSResource {

    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.GetSingleton: "/JSSResource/smtpserver",
        ResourcePaths.PutSingleton: "/JSSResource/smtpserver",
    ]
    
    var enabled: Bool = true
    var host: String? = nil
    var port: Int = 25
    var timeout: Int = 5
    var authorizationRequired: Bool = false
    var username: String? = nil
    var passwordSha256: String? = nil
    var ssl: Bool = false
    var tls: Bool = false
    var sendFromName: String? = nil
    var sendFromEmail: String? = nil
    
    required init() {
        super.init()
        self.rootTag = "smtp_server"
    }
 
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.enabled, forKey: "enabled")
        aCoder.encode(self.host, forKey: "host")
        aCoder.encode(self.port, forKey: "port")
        aCoder.encode(self.timeout, forKey: "timeout")
        aCoder.encode(self.authorizationRequired, forKey: "authorization_required")
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.passwordSha256, forKey: "password_sha256")
        aCoder.encode(self.ssl, forKey: "ssl")
        aCoder.encode(self.tls, forKey: "tls")
        aCoder.encode(self.sendFromName, forKey: "send_from_name")
        aCoder.encode(self.sendFromEmail, forKey: "send_from_email")
    }
}
