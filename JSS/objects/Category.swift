import Foundation

/**
 A category is used to organise many different types of objects in the JSS.
 Most objects will let you specify a category by name and not by ID.
 */
public class Category: JSSResource {

    /// The "None" category. Use this when you specifically want to un-set a category.
    public static var None: Category {
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
    
    /// Object Identifier
    public var id: Int = 0
    
    /// Category Name
    public var name: String? = nil
    
    public var priority: Int = 9
    
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
        aCoder.encode(self.priority, forKey:"priority")
    }
}
