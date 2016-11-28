import Foundation

class PackageStore : JSSStore {
    
    convenience init(api: API) {
        self.init(api: api, path: "/JSSResource/packages")
    }
    
    func all(completionHandler: @escaping ([Package]?, Error) -> Void) {
        let request = URLRequest(url: self.url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            if let err = error {
                completionHandler(nil, err)
            }
            
            if let content = data {
                let parser = XMLParser(data: content)
                var packages: Array<Package> = []
                
            } else {
                
            }
        }
    }
    
    func find(id: Int, completionHandler: @escaping (Package?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/packages/id/\(id)")
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let err = error {
                completionHandler(nil, err)
            }
            
            if let content = data {
                let parser = XMLParser(data: content)
                let package = Package()
                let mirrorParser = MirrorParser(reflecting: package)
                parser.delegate = mirrorParser
                
                parser.parse()
                
                completionHandler(package, nil)
            } else {
                
            }
        }
    }
    
    func create(_ package: Package, completionHandler: @escaping(Int?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/packages/id/0")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: package, rootTag: "package")
        
        print(xmlDoc.xmlString)
        
        self.api.postXML(request: request, xml: xmlDoc) {
            (data, response, error) in
            
            if let err = error {
                completionHandler(nil, err)
            }
            
            if let content = data {
                // success response
                print(String(data: content, encoding: .utf8))
                
                completionHandler(0, nil)
            } else {
                
            }
        }
    }
}
