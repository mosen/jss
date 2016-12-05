import Foundation

class Department: JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/departments/id/",
        ResourcePaths.FindByName: "/JSSResource/departments/name/",
        ResourcePaths.FindAll: "/JSSResource/departments",
        ResourcePaths.CreateById: "/JSSResource/departments/id/0",
        ResourcePaths.UpdateById: "/JSSResource/departments/id/",
        ResourcePaths.DeleteById: "/JSSResource/departments/id/",
    ]
    
    var id: Int = 0
    var name: String? = nil
    
    required init() {
        super.init()
        self.rootTag = "department"
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
    }
}
