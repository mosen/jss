import Foundation

let accountIntTypes = [
    "id"
]

class AccountParser : NSObject {
    var account: Account?
    var value: String?
    
    override init() {
        super.init()
    }
}

// MARK: - XMLParserDelegate
extension AccountParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "account":
            self.account = Account()
        default: break
        }
    }
    
    func parser(_: XMLParser, didEndElement: String, namespaceURI: String?, qualifiedName: String?) {
        switch didEndElement {
            case "id":
                if let value = self.value {
                    self.account?.id = Int(value)
                } else {
                    self.account?.id = nil
                }
            
            case "name":
                self.account?.username = self.value
            case "directory_user":
                self.account?.directoryUser = (self.value == "true")
            case "full_name":
                self.account?.fullName = self.value
        default:
            print("Unhandled element: \(didEndElement)")
        }
        
        self.value = .none
    }
    
    func parser(_: XMLParser, foundCharacters: String) {
        if let value = self.value {
            self.value = value + foundCharacters
        } else {
            self.value = foundCharacters
        }
    }
}
