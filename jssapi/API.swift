import Foundation

let jssRealm = "Restful JSS Access -- Please supply your credentials"

enum APIError : Error {
    case InvalidURL
    case NoResponse
    case InvalidContentType(String)
    
    // Response contains non 2xx code, may contain a response body
    case HTTP(Int, Data?)
    case Serialization
}

class API : NSObject {
    let credential: URLCredential
    let url: URL
    let protectionSpace: URLProtectionSpace
    
    init(url: URL, credential: URLCredential) throws {
        self.url = url
        self.credential = credential
        
        guard let host = url.host else {
            throw APIError.InvalidURL
        }
        
        let port = url.port ?? 8443
        self.protectionSpace = URLProtectionSpace(host: host, port: port, protocol: "https", realm: jssRealm, authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
        
        let sharedCredentials = URLCredentialStorage.shared
        sharedCredentials.setDefaultCredential(credential, for: protectionSpace)
        
        let defaultConfig = URLSessionConfiguration.default
        defaultConfig.httpAdditionalHeaders = [
            "Content-Type": "text/xml",
            "Accept": "text/xml"
        ]
        
        super.init()
    }
    
    // fetchXML "decorates" a dataTask by performing a bunch of sanity checking for each request by an object store
    func fetchXML(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            // Don't perform any checking if the datatask failed anyway.
            if error != nil {
                return completionHandler(data, response, error)
            }
            
            // Check HTTP response is what we expect.
            if let httpResponse = response as? HTTPURLResponse {
                if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String, contentType != "application/xml" {
                    return completionHandler(data, response, APIError.InvalidContentType(contentType))
                }
                
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                    return completionHandler(data, response, APIError.HTTP(httpResponse.statusCode, data))
                }
            }
            
            completionHandler(data, response, error)
        }
        
        task.resume()
    }
    
    func postXML(request: URLRequest, xml: XMLDocument, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.uploadTask(with: request, from: xml.xmlData) {
            (data, response, error) -> Void in
            // Don't perform any checking if the datatask failed anyway.
            if error != nil {
                return completionHandler(data, response, error)
            }
            
            // Check HTTP response is what we expect.
            if let httpResponse = response as? HTTPURLResponse {
                if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String, contentType != "application/xml" {
                    return completionHandler(data, response, APIError.InvalidContentType(contentType))
                }
                
                // PUT or POST should return 201
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                    return completionHandler(data, response, APIError.HTTP(httpResponse.statusCode, data))
                }
            }
            
            completionHandler(data, response, error)
        }
        
        task.resume()
    }

}
