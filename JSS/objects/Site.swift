import Foundation

public class Site: JSSResource {
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/sites/id/",
        ResourcePaths.FindByName: "/JSSResource/sites/name/",
        ResourcePaths.FindAll: "/JSSResource/sites",
        ResourcePaths.CreateById: "/JSSResource/sites/id/0",
        ResourcePaths.UpdateById: "/JSSResource/sites/id/",
        ResourcePaths.DeleteById: "/JSSResource/sites/id/",
    ]
    
    var id: Int = 0
    var name: String? = nil
    
    required public init() {
        super.init()
    }
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
    }
}
