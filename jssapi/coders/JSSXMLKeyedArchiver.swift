import Foundation

class JSSXMLKeyedArchiver: NSCoder {
    
    let doc: XMLDocument
    var root: XMLElement?
    var rootTag: String?
    var translationMap: [String:String] = [:]
    
    init(document: XMLDocument) {
        self.doc = document
    }
    
    class func archivedXML(withRootObject rootObject: Any, rootTag tag: String?) -> XMLDocument {
        let xmlDoc = XMLDocument()
        let jssArchiver = JSSXMLKeyedArchiver(document: xmlDoc)
        
        jssArchiver.rootTag = tag
        
        jssArchiver.encodeRootObject(rootObject)
        if let coderRootObject = rootObject as? NSCoding {
            coderRootObject.encode(with: jssArchiver)
        } else {
            print("object does not use NSCoding")
        }
        
        return xmlDoc
    }
    
    // MARK:- NSCoder REQUIRED
    override func encodeValue(ofObjCType type: UnsafePointer<Int8>, at addr: UnsafeRawPointer) {
        
    }
    
    override func encode(_ data: Data) {
        
    }
    
    override func decodeValue(ofObjCType type: UnsafePointer<Int8>, at data: UnsafeMutableRawPointer) {
        
    }
    
    override func decodeData() -> Data? {
        return nil
    }
    
    override func version(forClassName className: String) -> Int {
        return 1
    }
    
    override func encodeRootObject(_ rootObject: Any) {
        var rootElement: XMLElement
        
        if let tagName = self.rootTag {
            rootElement = XMLElement(name: tagName)
        } else {
            let rootObjectMirror = Mirror(reflecting: rootObject)
            let rootObjectClassname = String(describing: rootObjectMirror.subjectType)
            rootElement = XMLElement(name: rootObjectClassname.lowercased())
            print("root element is \(rootObjectClassname.lowercased())")
        }

        self.doc.setRootElement(rootElement)
    }
    
    // MARK:- Keyed Coding
    // Ideally to support the same methods as NSKeyedArchiver
    override var allowsKeyedCoding: Bool {
        get {
            return true
        }
    }
    
    override func encode(_ boolv: Bool, forKey key: String) {
        var boolElement : XMLElement
        
        if boolv {
            boolElement = XMLElement(name: key, stringValue: "true")
        } else {
            boolElement = XMLElement(name: key, stringValue: "false")
        }
        
        self.doc.rootElement()?.addChild(boolElement)
    }
    
    override func encode(_ intv: Int32, forKey key: String) {
        let strValue = String(intv)
        self.doc.rootElement()?.addChild(XMLElement(name: key, stringValue: strValue))
    }
    
    override func encode(_ intv: Int64, forKey key: String) {
        let strValue = String(intv)
        self.doc.rootElement()?.addChild(XMLElement(name: key, stringValue: strValue))
    }
    
    override func encode(_ objv: Any?, forKey key: String) {
        print("Encoding object for key \(key)")
        
        switch objv {
        case is String?:
            let element = XMLElement(name: key, stringValue: objv as? String)
            self.doc.rootElement()?.addChild(element)
        default:
            print("Unhandled type for key: \(key)")
        }
    }
    
    // MARK:- NSKeyedArchiver Simulation
    func setClassName(_ codedName: String?, for cls: AnyClass) {
        
    }
    
    func className(for cls: AnyClass) -> String? {
        return nil
    }
}
