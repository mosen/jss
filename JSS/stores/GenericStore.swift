import Foundation

enum StoreError : Error {
    case Serialization
    case EmptyContent
    case InvalidMethodForResource
}

public enum ResourcePaths {
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

/** 
 GenericStore implements a REST interface for every object type in the JSS using Generics
 to provide the find, all, create, save, and delete methods.
 
 It retrieves the relative path of the REST object from the JSSResource that it was created with.
 
 Example:
 ```swift
    let api = API(...)
    let bldgStore = GenericStore<Building>(api: api, paths: Building.resourcePaths)
 ```
*/
public class GenericStore<ResourceType: JSSResource> {
    let api: API
    var paths: Dictionary<ResourcePaths,String> = [:]
    
    public init(api: API, paths: Dictionary<ResourcePaths,String>) {
        self.api = api
        self.paths = paths
    }
    
    /**
     Get the values for a singleton object (eg. activation code)
     */
    public func get(completionHandler: @escaping (ResourceType?, Error?) -> Void) {
        guard let getSingletonPath = self.paths[ResourcePaths.GetSingleton] else {
            return completionHandler(nil, StoreError.InvalidMethodForResource)
        }
        
        let urlPath = getSingletonPath
        let url = self.api.url.appendingPathComponent(urlPath)
        let request = URLRequest(url: url)
        
        self.api.fetch(request: request) {
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
    public func put(_ resource: ResourceType, completionHandler: @escaping (Error?) -> Void) {
        guard let putSingletonPath = self.paths[ResourcePaths.PutSingleton] else {
            return completionHandler(StoreError.InvalidMethodForResource)
        }
        
        let urlPath = putSingletonPath
        let url = self.api.url.appendingPathComponent(urlPath)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: resource, rootTag: resource.rootTag)
        
        self.api.upload(request: request, data: xmlDoc.xmlData) {
            (data, response, error) in
            return completionHandler(error)
        }
    }
    
    /**
     Find an object by its ID.
     
     - Parameter id: The object identifier
     - Parameter completionHandler: A closure containing the optional result object, and an optional error
     */
    public func find(id: Int, completionHandler: @escaping (ResourceType?, Error?) -> Void) {
        guard let findByIdPath = self.paths[ResourcePaths.FindById] else {
            return completionHandler(nil, StoreError.InvalidMethodForResource)
        }
        
        let urlPath = findByIdPath + String(id)
        let url = self.api.url.appendingPathComponent(urlPath)
        let request = URLRequest(url: url)
        
        self.api.fetch(request: request) {
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
     
     - Parameter name: The object unique name
     - Parameter completionHandler: A closure containing the optional result object, and an optional error
     */
    public func find(name: String, completionHandler: @escaping (ResourceType?, Error?) -> Void) {
        guard let findByNamePath = self.paths[ResourcePaths.FindByName] else {
            return completionHandler(nil, StoreError.InvalidMethodForResource)
        }
        
        let urlPath = findByNamePath + name
        let url = self.api.url.appendingPathComponent(urlPath)
        let request = URLRequest(url: url)
        
        self.api.fetch(request: request) {
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
     
     - Parameter _ resource: The resource to create
     - Parameter completionHandler: A closure taking an optional new object ID and/or an error object.
     */
    public func create(_ resource: ResourceType, completionHandler: @escaping(Int?, Error?) -> Void) {
        guard let createByIdPath = self.paths[ResourcePaths.CreateById] else {
            return completionHandler(nil, StoreError.InvalidMethodForResource)
        }
        
        let url = self.api.url.appendingPathComponent(createByIdPath)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: resource, rootTag: resource.rootTag)
        print(xmlDoc.xmlString)
        
        self.api.upload(request: request, data: xmlDoc.xmlData) {
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
                        let id = Int(oidStr, radix: 10)
                        return completionHandler(id, nil)
                    }
                    
                    
                } catch {
                    return completionHandler(nil, error)
                }
            }
            
            return completionHandler(nil, StoreError.EmptyContent)
        }
    }
    
    /**
      Delete an object from the JSS by its identifier
     
     - Parameter id: The object identifier
     - Parameter completionHandler: A closure called with an Error object if one occurred.
     */
    public func delete(id: Int, completionHandler: @escaping(Error?) -> Void) {
        guard let deleteByIdPath = self.paths[ResourcePaths.DeleteById] else {
            return completionHandler(StoreError.InvalidMethodForResource)
        }
        
        let urlPath = deleteByIdPath + String(id, radix: 0)
        let url = self.api.url.appendingPathComponent(urlPath)
        let request = URLRequest(url: url)
        
        self.api.fetch(request: request) {
            (data, response, error) in
            completionHandler(error)
        }
    }
}
