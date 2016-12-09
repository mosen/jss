import Foundation

/**
 SMTP Server contains SMTP server connection information.
 */
public class SMTPServer: JSSResource {

    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.GetSingleton: "/JSSResource/smtpserver",
        ResourcePaths.PutSingleton: "/JSSResource/smtpserver",
    ]
    
    /// This SMTP connection is enabled
    public var enabled: Bool = true
    /// The hostname or IP address of the SMTP server
    public var host: String? = nil
    /// The TCP port of the SMTP service (Default: 25)
    public var port: Int = 25
    /// SMTP server connection timeout.
    public var timeout: Int = 5
    /// SMTP server requires authorization
    public var authorizationRequired: Bool = false
    /// SMTP server username
    public var username: String? = nil
    /// SMTP server password as SHA-256 hash
    public var passwordSha256: String? = nil
    /// SSL Enabled
    public var ssl: Bool = false
    /// TLS Enabled
    public var tls: Bool = false
    /// The name that the JSS will use to send e-mails from
    public var sendFromName: String? = nil
    /// The e-mail address that the JSS will use to send e-mails from.
    public var sendFromEmail: String? = nil
    
    required public init() {
        super.init()
        self.rootTag = "smtp_server"
    }
 
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override public func encode(with aCoder: NSCoder) {
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
