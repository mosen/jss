import Foundation

/**
 Department contains a department name only.
 */
public class Department: JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/departments/id/",
        ResourcePaths.FindByName: "/JSSResource/departments/name/",
        ResourcePaths.FindAll: "/JSSResource/departments",
        ResourcePaths.CreateById: "/JSSResource/departments/id/0",
        ResourcePaths.UpdateById: "/JSSResource/departments/id/",
        ResourcePaths.DeleteById: "/JSSResource/departments/id/",
    ]
    
    /// Object Identifier
    public var id: Int = 0
    
    /// Department name (must be unique)
    public var name: String? = nil
    
    required public init() {
        super.init()
        self.rootTag = "department"
    }
    
    // MARK:- NSCoding
    
    override public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
    }
}
