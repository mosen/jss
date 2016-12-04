import XCTest

class BuildingTests: APITestCase {

    func testCreateBuilding() {
        let expectation = self.expectation(description: "URLSessionDataTask Returns")
        
        do {
            let api = try API(url: url, credential: credential)
            let store : GenericStore<Building> = GenericStore(api: api, paths: Building.resourcePaths)
            let bldg = Building(name: "Test Building")
            
            store.create(bldg) {
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
