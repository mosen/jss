import Foundation

/**
 A script object represents a bash script stored in the JSS database.
 */
public class Script: JSSResource {
    static let resourcePaths : [ResourcePaths:String] = [
        ResourcePaths.FindById : "/JSSResource/scripts/id/",
        ResourcePaths.FindByName: "/JSSResource/scripts/name/",
        ResourcePaths.FindAll: "/JSSResource/scripts",
        ResourcePaths.CreateById: "/JSSResource/scripts/id/0",
        ResourcePaths.UpdateById: "/JSSResource/scripts/id/",
        ResourcePaths.DeleteById: "/JSSResource/scripts/id/",
        ]
    
    /// ImagingAction is specifically used for scripts to indicate when a script should run.
    public enum ImagingAction: String {
        case After = "After"
        case Before = "Before"
        case AtReboot = "At Reboot"
    }
    
    /// Object Identifier
    public var id: Int = 0
    
    /// Script name (must be unique)
    public var name: String? = nil
    
    /// Category
    public var category: Category? = nil
    
    /// Script filename
    public var filename: String? = nil
    
    /// Script information
    public var info: String? = nil
    
    /// Administrator notes
    public var notes: String? = nil
    
    /// When to execute the script (if part of imaging)
    public var priority: ImagingAction = .After
    
    //var osRequirements:
    /// Base64 encoded script content.
    public var scriptContentsEncoded: Data? = nil
}
