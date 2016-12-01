import Foundation

enum AndOr: String {
    case And = "and"
    case Or = "or"
}

enum CriterionOperator: String {
    case NotLike = "not like"
    case IsNot = "is not"
    case Has = "has"
    case DoesNotHave = "does not have"
}

class Criterion: NSCoding {
    var name: String? = nil
    var priority: Int = 0
    var andOr: String? = nil
    var searchType: String? = nil
    var value: String? = nil
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.priority, forKey: "priority")
        aCoder.encode(self.andOr, forKey: "and_or")
        aCoder.encode(self.searchType, forKey: "search_type")
        aCoder.encode(self.value, forKey: "value")
    }
}


class ComputerGroup: JSSResource {
    var id: Int = 0
    var name: String? = nil
    var isSmart: Bool = false
    
    var site: Site? = nil
    var criteria: [Criterion]? = nil
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.isSmart, forKey: "is_smart")
        aCoder.encode(self.site, forKey: "site")
        aCoder.encode(self.criteria, forKey: "criteria")
    }
}
