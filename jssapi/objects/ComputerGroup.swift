import Foundation

public enum AndOr: String {
    case And = "and"
    case Or = "or"
}

public enum CriterionOperator: String {
    case Is = "is"
    case Like = "like"
    case NotLike = "not like"
    case IsNot = "is not"
    case Has = "has"
    case DoesNotHave = "does not have"
    case MemberOf = "member of"
    case NotMemberOf = "not member of"
}

/**
 Criterion represents a single criterion used to query smart group membership.
 */
public class Criterion: NSCoding {
    
    /// The name of the attribute to match
    public var name: String? = nil
    
    /// The order in which this item appears in the criteria list.
    public var priority: Int = 0
    
    /// and/or
    public var andOr: AndOr? = .And
    
    /// the operator
    public var searchType: CriterionOperator? = nil
    
    /// The value to match using the searchType
    public var value: String? = nil
    
    // MARK:- NSCoding
    
    required public init?(coder aDecoder: NSCoder) {
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.priority, forKey: "priority")
        aCoder.encode(self.andOr, forKey: "and_or")
        aCoder.encode(self.searchType, forKey: "search_type")
        aCoder.encode(self.value, forKey: "value")
    }
}

/**
 A computer group represents both static and smart groups of computers.
 */
public class ComputerGroup: JSSResource {
    
    /// Object Identifier
    public var id: Int = 0
    
    /// Group name
    public var name: String? = nil
    
    /// Is this group a smart group?
    public var isSmart: Bool = false
    
    /// Associated site
    var site: Site? = nil
    
    /// Criteria used to determine Smart Group membership
    public var criteria: [Criterion]? = nil
    
    override public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.isSmart, forKey: "is_smart")
        aCoder.encode(self.site, forKey: "site")
        aCoder.encode(self.criteria, forKey: "criteria")
    }
}
