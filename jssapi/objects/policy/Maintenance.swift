import Foundation

class Maintenance: NSCoding {
    var recon: Bool = true
    var resetName: Bool = false
    var installAllCachedPackages: Bool = false
    var heal: Bool = false
    var prebindings: Bool = false
    var byhost: Bool = false
    var systemCache: Bool = false
    var userCache: Bool = false
    var verify: Bool = false
 
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.recon, forKey: "recon")
        aCoder.encode(self.resetName, forKey: "reset_name")
        aCoder.encode(self.installAllCachedPackages, forKey: "install_all_cached_packages")
        aCoder.encode(self.heal, forKey: "heal")
        aCoder.encode(self.prebindings, forKey: "prebindings")
        aCoder.encode(self.byhost, forKey: "byhost")
        aCoder.encode(self.systemCache, forKey: "system_cache")
        aCoder.encode(self.userCache, forKey:"user_cache")
        aCoder.encode(self.verify, forKey:"verify")
    }
}
