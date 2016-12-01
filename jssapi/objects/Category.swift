import Foundation

class Category: JSSResource {

    // Special category when none is set
    static var None: Category {
        get {
            let cat = Category()
            cat.id = -1
            cat.name = "No category assigned"
            return cat
        }
    }
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/categories/id/",
        ResourcePaths.FindByName: "/JSSResource/categories/name/",
        ResourcePaths.FindAll: "/JSSResource/categories",
        ResourcePaths.CreateById: "/JSSResource/categories/id/0",
        ResourcePaths.UpdateById: "/JSSResource/categories/id/",
        ResourcePaths.DeleteById: "/JSSResource/categories/id/",
    ]
    
    var id: Int = 0
    var name: String? = nil
    var priority: Int = 9
    
    required init() {
        super.init()
    }
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.priority, forKey:"priority")
    }
}
