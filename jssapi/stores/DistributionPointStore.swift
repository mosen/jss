import Foundation

class DistributionPointStore : JSSStore {
    
    func find(id: Int, completionHandler: @escaping (DistributionPoint?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/distributionpoints/id/\(id)")
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
    
    func create(_ distributionPoint: DistributionPoint, completionHandler: @escaping(DistributionPoint?, Error?) -> Void) {
        let url = self.api.url.appendingPathComponent("/JSSResource/distributionpoints/id/0")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let xmlDoc = JSSXMLKeyedArchiver.archivedXML(withRootObject: distributionPoint, rootTag: "distribution_point")
        
        self.api.postXML(request: request, xml: xmlDoc) {
            (data, response, error) in
            if let err = error {
                completionHandler(nil, err)
            }
            
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
            
            return completionHandler(nil, StoreError.EmptyContent)
        }
    }
}
