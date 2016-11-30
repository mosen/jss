import XCTest

class CoderTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    let selfService: SelfService = {
        let ss = SelfService()
        ss.useForSelfService = true
        ss.installButtonText = "Install Thing"
        ss.selfServiceDescription = "Some kind of policy item"
        
        let ssi = SelfServiceIcon()
        ssi.id = 1
        ssi.filename = "Icon.png"
        ssi.uri = "https://localhost:8443//iconservlet?id=1"
        
        ss.selfServiceIcon = ssi
        ss.featureOnMainPage = true
        let ssc = SelfServiceCategory()
        ssc.id = 2
        ssc.name = "Test"
        ssc.displayIn = true
        ssc.featureIn = true
        
        ss.selfServiceCategories = [ssc]
        
        return ss
    }()
    
    func testEncodeSelfService() {
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: self.selfService, rootTag: "self_service")
        print(xmlDoc.xmlString)
    }


}
