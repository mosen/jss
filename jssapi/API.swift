import Foundation

let jssRealm = "Restful JSS Access -- Please supply your credentials"

enum APIHTTPError : Error {
    case BadRequest // 400
    case AuthenticationFailed // 401
    case AuthorizationFailed // 403
    case NotFound // 404
    case ValidationFailed // 409 - also used for duplicates
    case InternalError // 500
    case Unknown(Int, Data?) // Any other HTTP error code
    
    case UnexpectedContentType // Server sent the wrong content - you should almost never see this
}

enum APIError : Error {
    case InvalidURL
}

class API : NSObject {
    let credential: URLCredential
    let url: URL
    let protectionSpace: URLProtectionSpace
    let sessionConfig: URLSessionConfiguration
    
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
        
        self.sessionConfig = URLSessionConfiguration.default
        self.sessionConfig.httpAdditionalHeaders = [
            "Content-Type": "text/xml",
            "Accept": "text/xml"
        ]
        
        super.init()
    }
    
    // fetchXML "decorates" a dataTask by performing a bunch of sanity checking for each request by an object store
    // a
    func fetchXML(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: self.sessionConfig)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            // Don't perform any checking if the datatask failed anyway.
            if error != nil {
                return completionHandler(data, response, error)
            }
            
            // Check HTTP response is what we expect.
            if let httpResponse = response as? HTTPURLResponse {
                if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String, contentType != "application/xml" {
                    return completionHandler(data, response, APIHTTPError.UnexpectedContentType)
                }
                
                // PUT or POST should return 201, GET 200
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                    switch httpResponse.statusCode {
                    case 400:
                        return completionHandler(data, response, APIHTTPError.BadRequest)
                    case 401:
                        return completionHandler(data, response, APIHTTPError.AuthenticationFailed)
                    case 403:
                        return completionHandler(data, response, APIHTTPError.AuthorizationFailed)
                    case 404:
                        return completionHandler(data, response, APIHTTPError.NotFound)
                    case 409:
                        return completionHandler(data, response, APIHTTPError.ValidationFailed)
                    case 500:
                        return completionHandler(data, response, APIHTTPError.InternalError)
                    default:
                        return completionHandler(data, response, APIHTTPError.Unknown(httpResponse.statusCode, data))
                    }
                }
            }
            
            completionHandler(data, response, error)
        }
        
        task.resume()
    }
    
    func postXML(request: URLRequest, xml: XMLDocument, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
//        let defaultConfig = URLSessionConfiguration.default
//        defaultConfig.httpAdditionalHeaders = [
//            "Content-Type": "text/xml",
//            "Accept": "text/xml"
//        ]
        
        let session = URLSession(configuration: self.sessionConfig)
        
        let task = session.uploadTask(with: request, from: xml.xmlData) {
            (data, response, error) -> Void in
            // Don't perform any checking if the datatask failed anyway.
            if error != nil {
                return completionHandler(data, response, error)
            }
            
            // Check HTTP response is what we expect.
            if let httpResponse = response as? HTTPURLResponse {

                // NOTE: This has been temporarily removed because JSS errors ignore Accept: header and use HTML anyway
                //                if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String, contentType != "application/xml" {
//                    return completionHandler(data, response, APIHTTPError.UnexpectedContentType)
//                }
                
                // PUT or POST should return 201
                if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                    switch httpResponse.statusCode {
                    case 400:
                        return completionHandler(data, response, APIHTTPError.BadRequest)
                    case 401:
                        return completionHandler(data, response, APIHTTPError.AuthenticationFailed)
                    case 403:
                        return completionHandler(data, response, APIHTTPError.AuthorizationFailed)
                    case 404:
                        return completionHandler(data, response, APIHTTPError.NotFound)
                    case 409:
                        return completionHandler(data, response, APIHTTPError.ValidationFailed)
                    case 500:
                        return completionHandler(data, response, APIHTTPError.InternalError)
                    default:
                        return completionHandler(data, response, APIHTTPError.Unknown(httpResponse.statusCode, data))
                    }
                }
            }
            
            completionHandler(data, response, error)
        }
        
        task.resume()
    }

}
