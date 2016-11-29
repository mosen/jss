import XCTest

class GenericStoreTests: XCTestCase {
    
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


    func testGenericFindById() {
        let expectation = self.expectation(description: "URL DataTask")
        
        do {
            let api = try API(url: url, credential: credential)
            let store : GenericStore<DistributionPoint> = GenericStore(api: api, paths: DistributionPoint.resourcePaths)
            store.find(id: 1) {
                (distributionPoint, error) in
                
                XCTAssertNil(error)
                
                if let err = error {
                    XCTFail("Got an error: \(err.localizedDescription)")
                    expectation.fulfill()
                } else {
                    XCTAssertNotNil(distributionPoint)
                    expectation.fulfill()
                }
            }
        } catch {
            expectation.fulfill()
            XCTFail(error.localizedDescription)
        }
        
        self.waitForExpectations(timeout: 5) {
            error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}
