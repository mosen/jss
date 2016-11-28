import Foundation


class Package : JSSResource {
    
    var id: Int = -1
    
    // General
    var name: String
    var category: String?
    var filename: String
    var info: String?
    var notes: String?
    
    // Options
    var priority: Int = 10
    var fillUserTemplate: Bool = false
    var fillExistingUsers: Bool = false
    var allowUninstalled: Bool = false
    var rebootRequired: Bool = false
    // Install on boot drive after imaging
    var bootVolumeRequired: Bool = false
    
    // Limitations
    var osRequirements: String?
    var installIfReportedAvailable: Bool = false
    var requireProcessor: String?
    var switchWithPackage: String?

    // Does not appear on ui
    var reinstallOption: String?
    var sendNotification: Bool = false
    
    init(name: String, filename: String) {
        self.name = name
        self.filename = filename
        
        super.init()
    }
    
    // Convert this struct to its API XML representation
    func toXML() -> XMLDocument {
        let doc = XMLDocument()
        let root = XMLElement(name: "package")
//        let numberFormatter = NumberFormatter()
//        
//        if let id = self.id {
//            let idEl = XMLElement(name: "id", stringValue: String(int: id))
//            root.addChild(idEl)
//        }
        
        let name = XMLElement(name: "name", stringValue: self.name)
        let filename = XMLElement(name: "filename", stringValue: self.filename)
        let category = XMLElement(name: "category", stringValue: self.category)
        let info = XMLElement(name: "info", stringValue: self.info)
        let notes = XMLElement(name: "notes", stringValue: self.notes)
        
        root.addChild(name)
        root.addChild(filename)
        root.addChild(category)
        root.addChild(info)
        root.addChild(notes)
        
        doc.setRootElement(root)
        
        return doc
    }
}
