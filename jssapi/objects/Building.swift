import Foundation

class Building : JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/buildings/id/",
        ResourcePaths.FindByName: "/JSSResource/buildings/name/",
        ResourcePaths.FindAll: "/JSSResource/buildings",
        ResourcePaths.CreateById: "/JSSResource/buildings/id/0",
        ResourcePaths.UpdateById: "/JSSResource/buildings/id/",
        ResourcePaths.DeleteById: "/JSSResource/buildings/id/",
    ]
    
    var id: Int = 0
    var name: String? = nil
    var streetAddress1: String? = nil
    var streetAddress2: String? = nil
    var city: String? = nil
    var stateProvince: String? = nil
    var zipPostalCode: String? = nil
    var country: String? = nil
    
    required init() {
        super.init()
        self.rootTag = "building"
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    override func encode(with aCoder: NSCoder) {
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
