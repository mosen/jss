import Foundation

class ConfigurationProfileGeneral {
    var id: Int = 0
    var name: String?
    var description: String?
    var site: Site? = nil
    var category: Category? = nil
    var userRemovable: Bool = false
    var level: ConfigurationProfile.Level = .Computer
    var uuid: UUID? = nil
    //var redeployOnUpdate: String = false
    var payloads: Data? = nil
}

class ConfigurationProfile {
    
    enum Level: String {
        case Computer = "computer"
        case User = "user"
    }
    
    enum InstallMethod: String {
        case Automatic = "Install Automatically"
        case SelfService = "Make Available in Self Service"
    }
    
    var general: ConfigurationProfileGeneral? = nil
    
}
