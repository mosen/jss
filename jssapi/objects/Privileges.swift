import Foundation

//struct Privileges {
//    let Objects: Set<JSSObjectPrivileges>
//    let Settings: Set<JSSSettingsPrivileges>
//    let Actions: Set<JSSActionsPrivileges>
//    let Recon: Set<ReconPrivileges>
//    let CasperAdmin: Set<CasperAdminPrivileges>
//    let CasperRemote: Set<CasperRemotePrivileges>
//    let CasperImaging: Set<CasperImagingPrivileges>
//}


enum JSSObjectPrivileges: String {
    case CreateAccounts = "Create Accounts"
    case ReadAccounts = "Read Accounts"
}

enum JSSSettingsPrivileges {
    
}

enum JSSActionsPrivileges {
    
}

enum ReconPrivileges {
    case AddComputersRemotely
    case CreateQuickAddPackages
}

enum CasperAdminPrivileges {
    
}

enum CasperRemotePrivileges {
    
}

enum CasperImagingPrivileges {
    
}
