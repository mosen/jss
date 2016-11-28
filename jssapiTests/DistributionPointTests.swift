import XCTest

class DistributionPointTests: XCTestCase {

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
    
    func testCreateDistributionPoint() {
        let expectation = self.expectation(description: "Create Distribution Point By Name 'fixture'")
        do {
            let api = try API(url: url, credential: credential)
            let store = DistributionPointStore(api: api, path: "/JSSResource/distributionpoints")
            let dp = DistributionPoint()
            dp.name = "fixture"
            dp.ipAddress = "localhost"
            dp.connectionType = "SMB"
            dp.shareName = "distribution_point"
            
            store.create(dp) {
                (updated, error) in
                
                if let err = error {
                    switch err {
                    case APIHTTPError.Unknown(_, let content):
                        print(String(data: content!, encoding: .utf8))
                    default: break
                    }
            
                    XCTFail("Did not get a distribution point: \(err.localizedDescription)")
                }
                
                XCTAssertNotNil(updated)
                

                
                if let distro = updated {
                    dump(distro)
                    expectation.fulfill()
                }
                
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

    func testFindDistributionPoint() {
        let expectation = self.expectation(description: "Find Distribution Point ID 1")
        
        do {
            let api = try API(url: url, credential: credential)
            let store = DistributionPointStore(api: api, path: "/JSSResource/distributionpoints")
            
            store.find(id: 1) {
                (dp, error) in
                XCTAssertNotNil(dp)
                
                if let err = error {
                    XCTFail("Did not get a distribution point: \(err.localizedDescription)")
                    expectation.fulfill()
                }
                
                if let distro = dp {
                    dump(distro)
                    expectation.fulfill()
                }
                
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
