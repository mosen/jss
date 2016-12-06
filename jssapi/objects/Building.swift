import Foundation

/**
 Building contains information about a building name and address.
 */
public class Building : JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/buildings/id/",
        ResourcePaths.FindByName: "/JSSResource/buildings/name/",
        ResourcePaths.FindAll: "/JSSResource/buildings",
        ResourcePaths.CreateById: "/JSSResource/buildings/id/0",
        ResourcePaths.UpdateById: "/JSSResource/buildings/id/",
        ResourcePaths.DeleteById: "/JSSResource/buildings/id/",
    ]
    
    /// Object identifier
    public var id: Int = 0
    
    /// Name of the building
    public var name: String? = nil
    
    /// Street Address (Line 1), Currently does not work with XML API
    public var streetAddress1: String? = nil
    
    /// Street Address (Line 2), Currently does not work with XML API
    public var streetAddress2: String? = nil
    
    /// City, Currently does not work with XML API
    public var city: String? = nil
    
    /// State/Province, Currently does not work with XML API
    public var stateProvince: String? = nil
    
    /// ZIP/Postal Code, Currently does not work with XML API
    public var zipPostalCode: String? = nil
    
    /// Country, Currently does not work with XML API
    public var country: String? = nil
    
    required public init() {
        super.init()
        self.rootTag = "building"
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    override public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.streetAddress1, forKey: "street_address_1")
        aCoder.encode(self.streetAddress2, forKey: "street_address_2")
        aCoder.encode(self.city, forKey: "city")
        aCoder.encode(self.stateProvince, forKey: "state_province")
        aCoder.encode(self.zipPostalCode, forKey: "zip_postal_code")
        aCoder.encode(self.country, forKey: "country")
    }
}
