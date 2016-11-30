import XCTest

class PackageTests: APITestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreatePackage() {
        let expectation = self.expectation(description: "URLSessionDataTask Returns")
        
        do {
            let api = try API(url: url, credential: credential)
            let store : GenericStore<Package> = GenericStore(api: api, paths: Package.resourcePaths)
            let pkg = Package()
            pkg.name = "fixture package"
            pkg.filename = "Fixture.dmg"
            
            store.create(pkg) {
                (id, error) in
                
                if let err = error as? APIHTTPError {
                    switch err {
                    case .BadRequest(let body):
                        dump(String(data: body!, encoding: .utf8))
                        XCTFail("Bad Request")
                    default:
                        XCTFail("HTTP Error")
                    }
                }
                
                XCTAssertNil(error)
                XCTAssertNotNil(id)
                expectation.fulfill()
            }
        } catch {
            XCTFail()
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) {
            error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }


}
