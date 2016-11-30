import Foundation

enum StoreError : Error {
    case Serialization
    case EmptyContent
    case InvalidMethodForResource
}

enum ResourcePaths {
    case GetSingleton // "/JSSResource/singleton"
    case PutSingleton // "/JSSResource/singleton"
    case FindById // "/JSSResource/object/id/"
    case FindByName // "/JSSResource/object/name/"
    case FindAll // "/JSSResource/objects"
    case CreateById // "/JSSResource/objects/id/0"
    case CreateByName // "/JSSResource/objects/name/xyz"
    case UpdateById // "/JSSResource/objects/id/x"
    case DeleteById // "/JSSResource/objects/id/x"
    case FindByCategory // "/JSSResource/objects/category/{name}"
}

// GenericStore implements a REST interface for every object type in the JSS using Generics
// to provide the find, all, create, save, and delete methods
class GenericStore<ResourceType: JSSResource> {
    let api: API
    var paths: Dictionary<ResourcePaths,String> = [:]
    
    init(api: API, paths: Dictionary<ResourcePaths,String>) {
        self.api = api
        self.paths = paths
    }
    
    /**
     Get the values for a singleton object (eg. activation code)
     */
    func get(completionHandler: @escaping (ResourceType?, Error?) -> Void) {
        guard let getSingletonPath = self.paths[ResourcePaths.GetSingleton] else {
            return completionHandler(nil, StoreError.InvalidMethodForResource)
        }
        
        let urlPath = getSingletonPath
        let url = self.api.url.appendingPathComponent(urlPath)
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let err = error {
                completionHandler(nil, err)
            }
            
            if let content = data {
                let parser = XMLParser(data: content)
                let obj = ResourceType()
                let mirrorParser = MirrorParser(reflecting: obj)
                
                parser.delegate = mirrorParser
                parser.parse()
                
                completionHandler(obj, nil)
            } else {
                completionHandler(nil, StoreError.EmptyContent)
            }
        }
    }
    
    /**
     Put the values for a singleton object, eg. activation code
     */
    func put(resource: ResourceType, completionHandler: @escaping (Error?) -> Void) {
        guard let putSingletonPath = self.paths[ResourcePaths.PutSingleton] else {
            return completionHandler(StoreError.InvalidMethodForResource)
        }
        
        let urlPath = putSingletonPath
        let url = self.api.url.appendingPathComponent(urlPath)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: resource, rootTag: resource.rootTag)
        
        self.api.postXML(request: request, xml: xmlDoc) {
            (data, response, error) in
            return completionHandler(error)
        }
    }
    
    /**
     Find an object by its ID.
     
     - parameter id: The object identifier
     - completionHandler: A closure which will be called with a tuple containing the resulting object, or an error
     */
    func find(id: Int, completionHandler: @escaping (ResourceType?, Error?) -> Void) {
        guard let findByIdPath = self.paths[ResourcePaths.FindById] else {
            return completionHandler(nil, StoreError.InvalidMethodForResource)
        }
        
        let urlPath = findByIdPath + String(id)
        let url = self.api.url.appendingPathComponent(urlPath)
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let err = error {
                completionHandler(nil, err)
            }
            
            if let content = data {
                let parser = XMLParser(data: content)
                let obj = ResourceType()
                let mirrorParser = MirrorParser(reflecting: obj)
                
                parser.delegate = mirrorParser
                parser.parse()
                
                completionHandler(obj, nil)
            } else {
                completionHandler(nil, StoreError.EmptyContent)
            }
        }
    }
    
    /**
     Find an object by its name.
     
     - name: The object unique name
     - completionHandler: A closure which will be called with a tuple containing the resulting object, or an error
     */
    func find(name: String, completionHandler: @escaping (ResourceType?, Error?) -> Void) {
        guard let findByNamePath = self.paths[ResourcePaths.FindByName] else {
            return completionHandler(nil, StoreError.InvalidMethodForResource)
        }
        
        let urlPath = findByNamePath + name
        let url = self.api.url.appendingPathComponent(urlPath)
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let content = data {
                let parser = XMLParser(data: content)
                let obj = ResourceType()
                let mirrorParser = MirrorParser(reflecting: obj)
                
                parser.delegate = mirrorParser
                parser.parse()
                
                return completionHandler(obj, nil)
            } else {
                return completionHandler(nil, StoreError.EmptyContent)
            }
        }
    }
    
    /**
     Create an object.
     */
    func create(_ resource: ResourceType, completionHandler: @escaping(Int?, Error?) -> Void) {
        guard let createByIdPath = self.paths[ResourcePaths.CreateById] else {
            return completionHandler(nil, StoreError.InvalidMethodForResource)
        }
        
        let url = self.api.url.appendingPathComponent(createByIdPath)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: resource, rootTag: resource.rootTag)
        
        self.api.postXML(request: request, xml: xmlDoc) {
            (data, response, error) in
            if let err = error {
                completionHandler(nil, err)
            }
            
            if let body = data {
                do {
                    let xmlDoc = try XMLDocument(data: body, options: 0)
                    let oidEl = try xmlDoc.rootElement()?.nodes(forXPath: "/\(resource.rootTag)/id")
                    
                    if oidEl?.count == 0 {
                        return completionHandler(nil, StoreError.EmptyContent)
                    }
                    
                    if let oidStr = oidEl?[0].stringValue {
                        let id = Int(oidStr, radix: 0)
                        return completionHandler(id, nil)
                    }
                    
                    
                } catch {
                    return completionHandler(nil, error)
                }
            }
            
            return completionHandler(nil, StoreError.EmptyContent)
        }
    }
    
//    func delete(_ resource: ResourceType, completionHandler: @escaping(Error?) -> Void) {
//        
//    }
    
    /**
      Delete an object from the JSS by its identifier
     */
    func delete(id: Int, completionHandler: @escaping(Error?) -> Void) {
        guard let deleteByIdPath = self.paths[ResourcePaths.DeleteById] else {
            return completionHandler(StoreError.InvalidMethodForResource)
        }
        
        let urlPath = deleteByIdPath + String(id, radix: 0)
        let url = self.api.url.appendingPathComponent(urlPath)
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            completionHandler(error)
        }
    }
}
