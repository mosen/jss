import XCTest

class ActivationCodeTests: XCTestCase {

    let url: URL = URL(string: "https://localhost:8444")!
    let credential: URLCredential = URLCredential(user: "admin", password: "pa$$w0rd", persistence: .forSession)
    
    func testGetActivationCode() {
        let expectation = self.expectation(description: "URLSessionDataTask Returns")
        
        do {
            let api = try API(url: url, credential: credential)
            let store: GenericStore<ActivationCode> = GenericStore(api: api, paths: ActivationCode.resourcePaths)
            
            store.get() {
                (code, error) in
                XCTAssertNotNil(code)
                
                if let err = error {
                    XCTFail("got some error: \(err.localizedDescription)")
                    expectation.fulfill()
                } else {
                    XCTAssertNotNil(code)
                    XCTAssertNotNil(code?.organizationName)
                    XCTAssertNotNil(code?.code)
                    expectation.fulfill()
                }
            }
        } catch {
            expectation.fulfill()
            XCTFail()
        }
        
        self.waitForExpectations(timeout: 10) {
            error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testPutInvalidActivationCode() {
        let expectation = self.expectation(description: "URLSessionDataTask Returns")
        let code = ActivationCode(organizationName: "JSS API", code: "CODE")
        
        do {
            let api = try API(url: url, credential: credential)
            let store : GenericStore<ActivationCode> = GenericStore(api: api, paths:ActivationCode.resourcePaths)
            
            store.put(resource: code) {
                (error) in
                XCTAssert(error is APIHTTPError)
                if let err = error as? APIHTTPError {
                
                    //XCTAssertEqual(err, APIHTTPError.ValidationFailed)
                }
                
                expectation.fulfill()
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
