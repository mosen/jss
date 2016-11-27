import Foundation

class AccountsStore {
    
    let api: API
    
    init(api: API) {
        self.api = api
    }
    
    func all(completionHandler: @escaping ([Account]?, Error?) -> Void) {
        let activationCodeURL = self.api.url.appendingPathComponent("/JSSResource/accounts")
        let request = URLRequest(url: activationCodeURL)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let content = data {
                do {
                    let parser = XMLParser(data: content)
                    let accountParser = AccountParser()
                    parser.delegate = accountParser
                    
                    parser.parse()
                    
                    let xmlContent = try XMLDocument(data: content, options: 0)
                    guard let rootElement = xmlContent.rootElement() else {
                        let err: Error? = StoreError.Serialization
                        return completionHandler(nil, err)
                    }
                    
                    if let accounts = Account.arrayFromXML(root: rootElement) {
                        return completionHandler(accounts, nil)
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
    
    func find(id: Int, completionHandler: @escaping (Account?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/accounts/userid/\(id)")
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let content = data {
                do {
                    let parser = XMLParser(data: content)
                    let accountParser = AccountParser()
                    parser.delegate = accountParser
                    
                    parser.parse()
                    
                    print(accountParser.account)
                    
                    let err: Error? = StoreError.Serialization
                    return completionHandler(nil, err)
                    
                    //                    let xmlContent = try XMLDocument(data: content, options: 0)
//                    guard let rootElement = xmlContent.rootElement() else {
//                        let err: Error? = StoreError.Serialization
//                        return completionHandler(nil, err)
//                    }
//                    
//                    if let account = Account.fromXML(root: rootElement) {
//                        return completionHandler(account, nil)
//                    } else {
//                        let err: Error? = StoreError.Serialization
//                        return completionHandler(nil, err)
//                    }
//                    
                    
                } catch {
                    return completionHandler(nil, error)
                }
            } else {
                return completionHandler(nil, StoreError.EmptyContent)
            }
        }
    }

//    func find(username: String, completionHandler: @escaping (Account?, Error?) -> Void) {
//        
//    }
    
//    func create(account: Account, completionHandler: @escaping (Account?, Error?) -> Void) {
//        
//    }

//    func delete(account: Account, completionHandler: @escaping (Error?) -> Void) {
//        
//    }
    
}