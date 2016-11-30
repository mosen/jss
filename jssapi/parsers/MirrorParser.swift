import Foundation

// Probably not the most elegant algorithm but it works
func toCamelCase(_ text: String) -> String {
    guard text.contains("_") else {
        return text
    }
    
    var snakedComponents = text.components(separatedBy: "_")
    let firstElement: String = snakedComponents.removeFirst()
    let restElements = snakedComponents.map() { $0.capitalized }
    
    return firstElement + restElements.joined()
}


// Parse elements found in XML if they match an objects properties via reflection
class MirrorParser : NSObject, XMLParserDelegate {
    
    let subject: AnyObject
    let mirror: Mirror
    var labels: [String] = []
    var currentLabel: String?
    var currentText: String?
    var ignoreCurrent: Bool = false
    // A dict of delegates with the type of element they can handle
    var delegates: [String:XMLParserDelegate] = [:]
    
    init(reflecting subject: AnyObject) {
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
        
        let camelElementName = toCamelCase(elementName)
        
        if labels.contains(camelElementName) {
            self.ignoreCurrent = false
            self.currentLabel = camelElementName
        } else {
            self.ignoreCurrent = true
            self.currentLabel = nil
        }
    }
    
    func parser(_: XMLParser, didEndElement: String, namespaceURI: String?, qualifiedName: String?) {
        if !self.ignoreCurrent {
            if let objectKey = self.currentLabel {
                print("Setting value for \(objectKey)")
    
                let val = self.subject.value(forKey: objectKey)
                
                switch val {
                case is String?, is String:
                    self.subject.setValue(self.currentText, forKey: objectKey)
                case is Int:
                    if let text = self.currentText {
                        let currentInt = Int(text) ?? -1
                        self.subject.setValue(currentInt, forKey: objectKey)
                    }
                case is Bool:
                    let currentBool = self.currentText?.caseInsensitiveCompare("true") == .orderedSame
                    self.subject.setValue(currentBool, forKey: objectKey)
                // KVC seems broken for URL type
                case is URL?:
                    fallthrough
                case is URL:
                    print("Testing URL type")
                    if let text = self.currentText, let url = URL(string: text) {
                        print(url.absoluteString)
                        self.subject.setValue(url, forKey: objectKey)
                    }
                default:
                    print("Unhandled type for key \(objectKey)")
                }
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
