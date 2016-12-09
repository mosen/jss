import Foundation

enum UapiError : Error {
    case InvalidJSONData
}

enum AuthenticationResult {
    case Success(Token)
    case Failure(Error)
}

enum UAPIPaths: String {
    case GenerateToken = "/uapi/auth/tokens"
}

class UAPI {
    
    let baseURL: URL
    let credential: URLCredential
    
    init(url: URL, credential: URLCredential) {
        self.baseURL = url
        self.credential = credential
    }
    
    func authenticate(completionHandler: @escaping (AuthenticationResult) -> Void) {
        let tokenUrl = URL(string: "https://localhost:8444/uapi/auth/tokens")!
        var req: URLRequest = URLRequest(url: tokenUrl)
        req.httpMethod = "POST"
    
        let userPasswordString = "\(self.credential.user ?? ""):\(self.credential.password ?? "")"
        let userPasswordData = userPasswordString.data(using: .utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        print(authString)
        print(tokenUrl.relativeString)
        
        req.setValue(authString, forHTTPHeaderField: "Authorization")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: req) {
            (data, response, error) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String, contentType != "application/json;charset=UTF-8" {
                        print("Got the wrong content type \(contentType)")
                }
            }
            
            if let jsonData = data {
                let jsonString: String = String(data: jsonData, encoding: .utf8)!
                NSLog(jsonString)
                
                do {
                    let jsonObject: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    
                    guard let jsonDictionary = jsonObject as? [String:AnyObject] else {
                        return completionHandler(.Failure(UapiError.InvalidJSONData))
                    }
                    
                    if let token = Token.fromJSONObject(json: jsonDictionary) {
                        completionHandler(.Success(token))
                    } else {
                        completionHandler(.Failure(UapiError.InvalidJSONData))
                    }
                }
                catch let error {
                    completionHandler(.Failure(error))
                }
            } else if let requestError = error {
                print("Error fetching devices \(requestError)")
            }
            else {
                print("Unexpected error with the request")
            }
        }

        task.resume()
    }
    
}
