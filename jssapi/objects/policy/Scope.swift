import Foundation

class Scope: NSCoding {
    var allComputers: Bool = false

    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.allComputers, forKey: "all_computers")
    }
}
