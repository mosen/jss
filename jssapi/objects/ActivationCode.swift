import Foundation

class ActivationCode : JSSResource {
    var organizationName: String?
    var code: String?
    
    override init() {
        super.init()
    }
    
    convenience init(organizationName: String, code: String) {
        self.init()
        self.organizationName = organizationName
        self.code = code
    }
    
    func toXML() -> XMLDocument {
        let doc = XMLDocument()
        let root = XMLElement(name: "activation_code")
        
        let org = XMLElement(name: "organization_name", stringValue: self.organizationName)
        let code = XMLElement(name: "code", stringValue: self.code)
        
        root.addChild(org)
        root.addChild(code)
        
        doc.setRootElement(root)
        
        return doc
    }
}
