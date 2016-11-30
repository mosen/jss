import Foundation


// We must inherit from NSObject to use Key-Value coding in MirrorParser
class JSSResource : NSObject, NSCoding {
    
    var rootTag: String = "JSSResource"
    
    required override init() {
        
    }
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
    }
}
