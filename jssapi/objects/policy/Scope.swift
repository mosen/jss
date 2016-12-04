import Foundation

class Scope: NSCoding {
    /// Target All Computers
    var allComputers: Bool = false
    /// Target All Users
    var allJssUsers: Bool = false

    //var computers: [Computer]? = nil
    var buildings: [Building]? = nil
    
    /// Targeted Computer Groups
    var computerGroups: [ComputerGroup]? = nil
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.allComputers, forKey: "all_computers")
        aCoder.encode(self.allJssUsers, forKey: "all_jss_users")
        
        
    }
}
