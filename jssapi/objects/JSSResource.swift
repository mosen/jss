import Foundation


// We must inherit from NSObject to use Key-Value coding in MirrorParser
class JSSResource : NSObject {
    
    var rootTag: String = "JSSResource"
    
    required override init() {
        
    }
}
