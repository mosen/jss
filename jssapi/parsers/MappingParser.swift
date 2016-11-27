import Foundation

protocol MappingSubject {
    func xmlTypeMap() -> [String:Any.Type]
    
}


class MappingParser : NSObject, XMLParserDelegate {
    
    let mirror: Mirror

    var currentText: String?
    
    init(subject: AnyObject) {
        self.mirror = Mirror(reflecting: subject)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {


    }
    
    func parser(_: XMLParser, didEndElement: String, namespaceURI: String?, qualifiedName: String?) {

        
        self.currentText = nil
    }
    
    func parser(_: XMLParser, foundCharacters: String) {
        if let value = self.currentText {
            self.currentText = value + foundCharacters
        } else {
            self.currentText = foundCharacters
        }
    }
}
