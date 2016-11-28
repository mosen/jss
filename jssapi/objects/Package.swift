import Foundation


class Package : JSSResource, NSCoding {
    
    var id: Int = -1
    
    // General
    var name: String?
    var category: String?
    var filename: String?
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
    
    override init() {
        super.init()
    }
    
    convenience init(name: String, filename: String) {
        self.init()
        
        self.name = name
        self.filename = filename
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
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.category, forKey:"category")
        aCoder.encode(self.filename, forKey:"filename")
        aCoder.encode(self.info, forKey:"info")
        aCoder.encode(self.notes, forKey:"notes")
        aCoder.encode(self.priority, forKey:"priority")
        aCoder.encode(self.fillUserTemplate, forKey:"fill_user_template")
        aCoder.encode(self.fillExistingUsers, forKey:"fill_existing_users")
        aCoder.encode(self.allowUninstalled, forKey:"allow_uninstalled")
        aCoder.encode(self.rebootRequired, forKey:"reboot_required")
        aCoder.encode(self.bootVolumeRequired, forKey:"boot_volume_required")
        aCoder.encode(self.osRequirements, forKey:"os_requirements")
        aCoder.encode(self.installIfReportedAvailable, forKey:"install_if_reported_available")
        aCoder.encode(self.requireProcessor, forKey:"require_processor")
        aCoder.encode(self.switchWithPackage, forKey:"switch_with_package")
        aCoder.encode(self.reinstallOption, forKey:"reinstall_option")
        aCoder.encode(self.sendNotification, forKey:"send_notification")
    }
}
