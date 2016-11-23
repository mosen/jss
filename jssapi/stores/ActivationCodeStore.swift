import Foundation

class ActivationCodeStore {
    
    let api: API
    let url: URL
    
    init(api: API) {
        self.api = api
        self.url = self.api.url.appendingPathComponent("/JSSResource/activationcode")
    }
    
    // Get the JSS activation code
    func get(completionHandler: @escaping (ActivationCode?, Error?) -> Void) {
        let request = URLRequest(url: self.url)

        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let content = data {
                do {
                    let xmlContent = try XMLDocument(data: content, options: 0)
                    guard let rootElement = xmlContent.rootElement() else {
                        let err: Error? = StoreError.Serialization
                        return completionHandler(nil, err)
                    }
                    
                    if let activationCode = ActivationCode.fromXML(root: rootElement) {
                        return completionHandler(activationCode, nil)
                    } else {
                        let err: Error? = StoreError.Serialization
                        return completionHandler(nil, err)
                    }
                    
                    
                } catch {
                    return completionHandler(nil, error)
                }
            } else {
                return completionHandler(nil, StoreError.EmptyContent)
            }
        }
    }
    
    // Update the JSS activation code
    func put(code: ActivationCode, completionHandler: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: self.url)
        request.httpMethod = "PUT"
        let xmlDoc = code.toXML()
        
        self.api.postXML(request: request, xml: xmlDoc) {
            (data, response, error) in
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
            
            
            if let d = data {
                let stringData = String(data: d, encoding: .utf8)
                print(stringData)
            }
            
            completionHandler(true, error)
            
        }
    }
}
