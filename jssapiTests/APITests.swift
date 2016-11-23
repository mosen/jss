
import XCTest

class APITests: XCTestCase {

    let url: URL = URL(string: "https://localhost:8444")!
    let credential: URLCredential = URLCredential(user: "admin", password: "pa$$w0rd", persistence: .forSession)
    
    func testBasicAuth() {
        let expectation = self.expectation(description: "API dataTask Returns")
        
        do {
            let api = try API(url: url, credential: credential)
            let store = ActivationCodeStore(api: api)
            
            store.get() {
                (code, error) in
                XCTAssertNotNil(code)
                
                if let err = error {
                    switch err {
                    case let APIError.HTTP(statusCode, body):
                        XCTFail("got http error, code: \(statusCode)")
                    default:
                        XCTFail("got some error")
                    }
                    
                    expectation.fulfill()
                }
                
                if let activationCode = code {
                    print("Activation Code")
                    print("Organization: \(activationCode.organizationName)")
                    print("Code: \(activationCode.code)")
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
    
    func testPutActivationCode() {
        let expectation = self.expectation(description: "PUT ActivationCode")
        let code = ActivationCode(organizationName: "JSS API", code: "CODE")
        
        do {
            let api = try API(url: url, credential: credential)
            let store = ActivationCodeStore(api: api)
            
            store.put(code: code) {
                (success, error) in
                XCTAssertTrue(success)
                if let err = error {
                    switch err {
                    case let APIError.HTTP(statusCode, _):
                        XCTFail("got http error, code: \(statusCode)")
                    default:
                        XCTFail("got some error")
                    }
                }
                
                expectation.fulfill()
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
    
    func testFindAccount() {
        let expectation = self.expectation(description: "Find Account ID 1")
        
        do {
            let api = try API(url: url, credential: credential)
            let store = AccountsStore(api: api)
            
            store.find(id: 1) {
                (account, error) in
                XCTAssertNotNil(account)
                
                if let err = error {
                    XCTFail("Did not get an account")
                    expectation.fulfill()
                }
                
                if let acct = account {
                    print(acct)
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
