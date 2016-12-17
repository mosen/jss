import XCTest

class XMLArrayTests: APITestCase {
    
    func testSerializeXMLArray() {
        let a: XMLArray<String> = XMLArray(collectionTag: "foo", itemTag: "bar", items: ["foo","bar","baz"])
        
    }
}
