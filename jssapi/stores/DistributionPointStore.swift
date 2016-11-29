import Foundation

class DistributionPointStore : JSSStore {


    
    /**
      Get a list of all distribution points.
    */
    func all(completionHandler: @escaping ([DistributionPoint]?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/distributionpoints")
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let content = data {
                let parser = XMLParser(data: content)
                var dps: [DistributionPoint] = []

                
                return completionHandler(dps, nil)
            } else {
                return completionHandler(nil, StoreError.EmptyContent)
            }
        }
    }
    
    /**
      Find a distribution point by its ID.
    */
    func find(id: Int, completionHandler: @escaping (DistributionPoint?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent(DistributionPoint.resourcePaths[ResourcePaths.FindById]!)
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let content = data {
                let parser = XMLParser(data: content)
                let dp = DistributionPoint()
                let mirrorParser = MirrorParser(reflecting: dp)
                parser.delegate = mirrorParser
                parser.parse()
                
                return completionHandler(dp, nil)
            } else {
                return completionHandler(nil, StoreError.EmptyContent)
            }
        }
    }

    /**
      Find a distribution point by name.
    */
    func find(name: String, completionHandler: @escaping (DistributionPoint?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/distributionpoints/name/\(name)")
        let request = URLRequest(url: url)
        
        self.api.fetchXML(request: request) {
            (data, response, error) in
            
            if let content = data {
                let parser = XMLParser(data: content)
                let dp = DistributionPoint()
                let mirrorParser = MirrorParser(reflecting: dp)
                parser.delegate = mirrorParser
                parser.parse()
                
                return completionHandler(dp, nil)
            } else {
                return completionHandler(nil, StoreError.EmptyContent)
            }
        }
    }
    
    /**
      Create a distribution point.

      - parameter distributionPoint: The details of the distribution point to create. Not validated.
      - parameter completionHandler: A completion handler that will be called with the ID of the created distribution
      point, or an error if it was not created.
    */
    func create(_ distributionPoint: DistributionPoint, completionHandler: @escaping(Int?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/distributionpoints/id/0")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: distributionPoint, rootTag: "distribution_point")
        print(xmlDoc.xmlString)
        
        self.api.postXML(request: request, xml: xmlDoc) {
            (data, response, error) in
            if let err = error {
                completionHandler(nil, err)
            }
            
            if let body = data {
                do {
                    let xmlDoc = try XMLDocument(data: body, options: 0)
                    let packageIdEl = try xmlDoc.rootElement()?.nodes(forXPath: "/package/id")

                    if packageIdEl?.count == 0 {
                        return completionHandler(nil, StoreError.EmptyContent)
                    }

                    if let packageIdStr = packageIdEl?[0].stringValue {
                        let packageId = Int(packageIdStr, radix: 0)
                        return completionHandler(packageId, nil)
                    }


                } catch {
                    return completionHandler(nil, error)
                }
            }
            
            return completionHandler(nil, StoreError.EmptyContent)
        }
    }
    
    func save(_ distributionPoint: DistributionPoint, completionHandler: @escaping(Bool, Error?) -> Void) {
        
    }
    
    func delete(_ distributionPoint: DistributionPoint, completionHandler: @escaping(Bool, Error?) -> Void) {
        
    }
}
