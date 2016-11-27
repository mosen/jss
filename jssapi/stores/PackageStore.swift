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
            
//            if let content = data {
//                do {
//                    let parser = XMLParser(data: content)
//                    
//                }
//            } else {
//                
//            }
        }
    }
    
    func get(id: Int) {
    }
}
