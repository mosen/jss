import XCTest

class SMTPServerTests: APITestCase {

    let smtpServer: SMTPServer = {
        let srv = SMTPServer()
        srv.enabled = true
        srv.host = "localhost"
        srv.authorizationRequired = false
        srv.port = 1025
        srv.sendFromEmail = "jss@localhost"
        srv.sendFromName = "Testing JSS"
        srv.ssl = false
        srv.tls = false
        
        return srv
    }()

    func testPutSMTPServer() {
        let expectation = self.expectation(description: "URLSessionDataTask Returns")
        
        do {
            let api = try API(url: url, credential: credential)
            let store : GenericStore<SMTPServer> = GenericStore(api: api, paths: SMTPServer.resourcePaths)
            
            store.put(self.smtpServer) {
                (error) in
                
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
