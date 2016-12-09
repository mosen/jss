import Foundation


/**
 JSSResource is the base class that all JSS Objects must inherit.
 It conforms to NSObject in order to use key-value coding during XML parsing.
 It conforms to NSCoding to produce XML.
 
 Objects that inherit from JSSResource may set the `rootTag` variable to control
 the tag name produced when they are encoded at the root of an XMLDocument.
*/
public class JSSResource : NSObject, NSCoding {
    
    /// XML tag name used when this object will be encoded at the root of a document.
    public var rootTag: String = "JSSResource"
    
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
