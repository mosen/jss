import Foundation

class Reboot: NSCoding {
    
    enum StartupDisk: String {
        case Current = "Current Startup Disk"
        case CurrentNoBless = "Currently Selected Startup Disk (No Bless)"
        case NetBoot = "NetBoot"
        case OSXInstaller = "OS X Installer"
        case Specify = "Specify Local Startup Disk"
    }
    
    enum RestartAction: String {
        case RestartIfRequired = "Restart if a package or update requires it"
        case Restart = "Restart immediately"
        case DontRestart = "Do not restart"
    }
    
    var message: String? = nil
    var startupDisk: Reboot.StartupDisk? = nil
    var specifyStartup: String? = nil
    var noUserLoggedIn: Reboot.RestartAction? = nil
    var userLoggedIn: Reboot.RestartAction? = nil
    var minutesUntilReboot: Int = 5
    var fileVault2Reboot: Bool = false
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.message, forKey: "message")
        aCoder.encode(self.startupDisk, forKey: "startup_disk")
        aCoder.encode(self.specifyStartup, forKey: "specify_startup")
        aCoder.encode(self.noUserLoggedIn, forKey: "no_user_logged_in")
        aCoder.encode(self.userLoggedIn, forKey: "user_logged_in")
        aCoder.encode(self.minutesUntilReboot, forKey: "minutes_until_reboot")
        aCoder.encode(self.fileVault2Reboot, forKey: "file_vault_2_reboot")
    }
}
