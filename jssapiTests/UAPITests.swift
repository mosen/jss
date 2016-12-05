import XCTest

class UapiTests: XCTestCase {

    static let testURL = URL(string: "https://localhost:8444")!
    var adminCredentials: URLCredential = URLCredential(user: "admin", password: "pa$$w0rd", persistence: .permanent)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAuthentication() {
        let uapi = UAPI(url: UapiTests.testURL, credential: self.adminCredentials)
        let expectation = self.expectation(description: "Authentication")
        
        uapi.authenticate() {
            (result) -> Void in
            
            switch result {
            case .Failure(let error):
                print("Failed!")
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            case .Success(let token):
                print("Got Token!")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
