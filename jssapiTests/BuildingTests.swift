import XCTest

class BuildingTests: APITestCase {

    var building: Building = {
        let building = Building()
        building.name = "HQ"
        building.streetAddress1 = "1 Fictional st"
        building.streetAddress2 = "Somewheresville"
        building.city = "Sydney"
        building.country = "Australia"
        
        return building
    }()
    
    func testCreateBuilding() {
        let expectation = self.expectation(description: "URL DataTask")
        
        do {
            let api = try API(url: url, credential: credential)
            let store : GenericStore<Building> = GenericStore(api: api, paths: Building.resourcePaths)
            store.create(self.building) {
                (id, error) in
                
                XCTAssertNil(error)
                
                if let err = error {
                    XCTFail("Got an error: \(err.localizedDescription)")
                    expectation.fulfill()
                } else {
                    XCTAssertNotNil(id)
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
