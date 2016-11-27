import Foundation

// Parse elements found in XML if they match an objects properties via reflection

class MirrorParser : NSObject, XMLParserDelegate {
    
    let subject: AnyObject
    let mirror: Mirror
    var labels: [String] = []
    var currentLabel: String?
    var currentText: String?
    var ignoreCurrent: Bool = false
    
    init(subject: AnyObject) {
        self.subject = subject
        self.mirror = Mirror(reflecting: subject)
        
        for child in self.mirror.children {
            if let childLabel = child.label {
                self.labels.append(childLabel)
            }
        }
    }
    
    // MARK:- XMLParserDelegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if labels.contains(elementName) {
            self.ignoreCurrent = false
            self.currentLabel = elementName
        } else {
            self.ignoreCurrent = true
            self.currentLabel = nil
        }
    }
    
    func parser(_: XMLParser, didEndElement: String, namespaceURI: String?, qualifiedName: String?) {
        if !self.ignoreCurrent {
            if let objectKey = self.currentLabel {
                self.subject.setValue("asd", forKey: #keyPath(objectKey))
            }
        } else {
            print("Ignored XML tag: \(didEndElement)")
        }
        
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
