import Foundation


// We must inherit from NSObject to use Key-Value coding in MirrorParser
public class JSSResource : NSObject, NSCoding {
    
    var rootTag: String = "JSSResource"
    
    required override public init() {
        
    }
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    public func encode(with aCoder: NSCoder) {
    }
}
