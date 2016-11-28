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
}
