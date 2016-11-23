import Foundation

struct ActivationCode {
    var organizationName: String
    var code: String
    
    static func fromXML(root: XMLElement) -> ActivationCode? {
        do {
            let activationCodeEl = try root.nodes(forXPath: "/activation_code/code")[0]
            let activationOrgEl = try root.nodes(forXPath: "/activation_code/organization_name")[0]
            
            let activationCode = ActivationCode(organizationName: activationOrgEl.stringValue!, code: activationCodeEl.stringValue!)
            return activationCode
        } catch {
            return nil
        }
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
