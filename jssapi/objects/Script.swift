import Foundation

class Script: JSSResource {
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/scripts/id/",
        ResourcePaths.FindByName: "/JSSResource/scripts/name/",
        ResourcePaths.FindAll: "/JSSResource/scripts",
        ResourcePaths.CreateById: "/JSSResource/scripts/id/0",
        ResourcePaths.UpdateById: "/JSSResource/scripts/id/",
        ResourcePaths.DeleteById: "/JSSResource/scripts/id/",
        ]
    
    enum ImagingAction: String {
        case After = "After"
        case Before = "Before"
        case AtReboot = "At Reboot"
    }
    
    var id: Int = 0
    var name: String? = nil
    
    var category: Category? = nil
    var filename: String? = nil
    var info: String? = nil
    var notes: String? = nil
    var priority: ImagingAction = .After
    //var osRequirements:
    var scriptContentsEncoded: Data? = nil
}
