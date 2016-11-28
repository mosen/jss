import XCTest

class PackageTests: XCTestCase {

    let url: URL = URL(string: "https://localhost:8444")!
    let credential: URLCredential = URLCredential(user: "admin", password: "pa$$w0rd", persistence: .forSession)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreatePackage() {
        let expectation = self.expectation(description: "URLSession finishes")
        do {
            let api = try API(url: url, credential: credential)
            let store = PackageStore(api: api, path: "/JSSResource/packages")
            let pkg = Package()
            pkg.name = "fixture package"
            pkg.filename = "Fixture.dmg"
            
            store.create(pkg) {
                (id, error) in
                
                if let err = error {
                    switch err {
                    case APIHTTPError.Unknown(let code, let content):
                        print("Error HTTP Code: \(code)")
                        print(String(data: content!, encoding: .utf8))
                    default: break
                    }
                    
                    XCTFail("Did not get a distribution point: \(err.localizedDescription)")
                }
                
                XCTAssertNotNil(id)
                
            }
        } catch {
            expectation.fulfill()
            XCTFail()
        }
        
        self.waitForExpectations(timeout: 5) {
            error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }


}
