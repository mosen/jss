import Foundation

class ActivationCodeStore : JSSStore {
    
    // Get the JSS activation code
    func get(completionHandler: @escaping (ActivationCode?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/activationcode")
        let request = URLRequest(url: url)

        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let content = data {
                do {
                    let parser = XMLParser(data: content)
                    let activationCode = ActivationCode()
                    let mirrorParser = MirrorParser(reflecting: activationCode)
                    parser.delegate = mirrorParser
                    parser.parse()
                    
                    return completionHandler(activationCode, nil)
                    
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
        let url = self.api.url.appendingPathComponent("/JSSResource/activationcode")
        var request = URLRequest(url: url)
        
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
