import Foundation

/**
 Package contains information about a package stored on a distribution point.
 */
public class Package : JSSResource {
    
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/packages/id/",
        ResourcePaths.FindByName: "/JSSResource/packages/name/",
        ResourcePaths.FindAll: "/JSSResource/packages",
        ResourcePaths.CreateById: "/JSSResource/packages/id/0",
        ResourcePaths.UpdateById: "/JSSResource/packages/id/",
        ResourcePaths.DeleteById: "/JSSResource/packages/id/",
    ]
    
    /// Object Identifier
    public var id: Int = 0
    
    // General
    /// Display name for the package
    public var name: String?
    /// Assigned category
    public var category: String?
    /// Filename of the package on the distribution point (e.g. "MyPackage.dmg")
    public var filename: String?
    /// Information to display to the administrator when the package is deployed or uninstalled
    public var info: String?
    /// Notes to display about the package (e.g. who built it and when it was built)
    public var notes: String?
    
    // Options
    /// Priority to use for deploying or uninstalling the package 
    /// - Note: (e.g. A package with a priority of "1" is deployed or uninstalled before other packages)
    public var priority: Int = 10
    /// Fill user templates (FUT)
    /// - Note: Fill new home directories with the contents of the home directory in the package's Users folder. Applies to DMGs only. This setting can be changed when deploying or uninstalling the package using a policy
    public var fillUserTemplate: Bool = false
    /// Fill existing user home directories (FEU)
    /// - Note: Fill existing home directories with the contents of the home directory in the package's Users folder. Applies to DMGs only. This setting can be changed when deploying or uninstalling the package using a policy
    public var fillExistingUsers: Bool = false
    /// Allow the package to be uninstalled using Casper Remote or a policy. Applies to indexed packages only
    public var allowUninstalled: Bool = false
    /// Computers must be restarted after installing the package
    public var rebootRequired: Bool = false
    /// Install on boot drive after imaging
    public var bootVolumeRequired: Bool = false
    
    // Limitations
    var osRequirements: String?
    var installIfReportedAvailable: Bool = false
    var requireProcessor: String?
    var switchWithPackage: String?

    // Does not appear on ui
    var reinstallOption: String?
    var sendNotification: Bool = false
    
    required public init() {
        super.init()
    }
    
    convenience init(name: String, filename: String) {
        self.init()
        
        self.name = name
        self.filename = filename
    }
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override public func encode(with aCoder: NSCoder) {
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
