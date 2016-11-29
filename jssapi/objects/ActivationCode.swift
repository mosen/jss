import Foundation

class ActivationCode : JSSResource, NSCoding {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.GetSingleton: "/JSSResource/activationcode",
        ResourcePaths.PutSingleton: "/JSSResource/activationcode",
    ]
    
    var organizationName: String?
    var code: String?
    
    required init() {
        super.init()
        self.rootTag = "activation_code"
    }
    
    convenience init(organizationName: String, code: String) {
        self.init()
        self.organizationName = organizationName
        self.code = code
    }
    
    // MARK:- NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.organizationName, forKey: "organization_name")
        aCoder.encode(self.code, forKey: "code")
    }
    
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
}
