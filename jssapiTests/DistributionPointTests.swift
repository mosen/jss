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
            let store: GenericStore<DistributionPoint> = GenericStore(api: api, paths: DistributionPoint.resourcePaths)
            let dp = DistributionPoint()
            dp.name = "fixture"
            dp.ipAddress = "localhost"
            dp.connectionType = "SMB"
            dp.isMaster = false
            dp.shareName = "distribution_point"
            dp.sharePort = 7139
            dp.readOnlyUsername = "jss"
            dp.readOnlyPasswordSha256 = "7cb9fc59c2d43289019b8324b342505401dcaebbc780f57c7030a8fa4a1afa5d"
            dp.readWriteUsername = "jss"
            dp.readWritePasswordSha256 = "7cb9fc59c2d43289019b8324b342505401dcaebbc780f57c7030a8fa4a1afa5d"
            
            store.create(dp) {
                (updated, error) in
                expectation.fulfill()
                
                if let err = error {
                    switch err {
                    case APIHTTPError.BadRequest:
                        print("BAD REQ")
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
            let store: GenericStore<DistributionPoint> = GenericStore(api: api, paths: DistributionPoint.resourcePaths)
            
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
