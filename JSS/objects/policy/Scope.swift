import Foundation

/**
 Scope contains policy scope information.
 
 Policies can be applied to specific computers, computer groups, users, and buildings.
 */
public class Scope: NSCoding {
    /// Target All Computers
    var allComputers: Bool = false
    /// Target All Users
    var allJssUsers: Bool = false

    //var computers: [Computer]? = nil

    
    /// Targeted Computer Groups
    public var computerGroups: [ComputerGroup]? = nil
    
    //public var users: [User]? = nil
    
    //public var userGroups: [UserGroup]? = nil
    
    
    /// Targeted Buildings
    public var buildings: [Building]? = nil
    
    /// Targeted Departments
    public var departments: [Department]? = nil
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.allComputers, forKey: "all_computers")
        aCoder.encode(self.allJssUsers, forKey: "all_jss_users")
        
        
    }
}
