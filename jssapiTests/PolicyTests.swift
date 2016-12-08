import XCTest

class PolicyTests: APITestCase {

    func testEncodeGeneral() {
        let general: PolicyGeneral = PolicyGeneral()
        general.enabled = true
        general.name = "General Encoding"
        general.offline = false
        general.triggerLogin = true
        
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: general, rootTag: "general")
        print(xmlDoc.xmlString)
    }
    
    func testCreateEmptyPolicy() {
        let policy = Policy()
        
        policy.general?.enabled = true
        
    }

}
