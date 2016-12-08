import Foundation

/**
 ActivationCode contains information about the JSS Activation Code and Registered Organization.
 */
public class ActivationCode : JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.GetSingleton: "/JSSResource/activationcode",
        ResourcePaths.PutSingleton: "/JSSResource/activationcode",
    ]
    
    /// organizationName: The name of the registered organization
    public var organizationName: String?
    
    /// The JSS activation code
    public var code: String?
    
    required public init() {
        super.init()
        self.rootTag = "activation_code"
    }
    
    convenience init(organizationName: String, code: String) {
        self.init()
        self.organizationName = organizationName
        self.code = code
    }
    
    // MARK:- NSCoding
    override public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.organizationName, forKey: "organization_name")
        aCoder.encode(self.code, forKey: "code")
    }
    
    // Don't care about decoding
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
}
