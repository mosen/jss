import Foundation

struct SystemInformation {
    var isVppTokenEnabled: Bool
    var isDepAccountEnabled: Bool
    var isByodEnabled: Bool
    var isUserMigrationEnabled: Bool
    var isCloudMigrationEnabled: Bool
    var isPatchEnabled: Bool
    var isSsoSamlEnabled: Bool
    var ssoSamlLoginUri: String?
}
