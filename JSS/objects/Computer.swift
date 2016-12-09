import Foundation

public class StorageDevicePartition {
    
    public enum PartitionType {
        case Boot
        case Other
    }
    
    /// The partition label (name)
    public var name: String? = nil
    /// The partition size (in mb)
    public var size: Int = 0
    /// The partition type
    public var type: PartitionType = .Other
    /// The partition size (in mb)
    public var partitionCapacityMb: Int = 0
    /// Percentage of capacity used
    public var percentageFull: Float = 0.0
    /// FileVault status
    public var fileVaultStatus: String? = nil
    /// FileVault percent
    public var fileVaultPercent: Float = 0.0
    /// FileVault2 status
    public var fileVault2Status: String? = nil
    /// FileVault2 percent
    public var fileVault2Percent: Float = 0.0
    /// Boot drive available megabytes.
    public var bootDriveAvailableMb: Int = 0
    /// Logical Volume Group UUID
    public var lvgUUID: UUID?
    /// Logical Volume UUID
    public var lvUUID: UUID?
    /// Physical Volume UUID
    public var pvUUID: UUID?
}


public class StorageDevice {
    /// The disk device name (under /dev)
    public var disk: String? = nil
    /// The disk manufacturer model
    public var model: String? = nil
    /// The disk firmware revision
    public var revision: String? = nil
    /// Serial number
    public var serialNumber: String? = nil
    /// Total capacity (in mb)
    public var size: Int = 0
    /// Total capacity (in mb)
    public var driveCapacityMb: Int = 0
    /// Connection Type
    public var connectionType: String? = nil
    /// S.M.A.R.T Status
    public var smartStatus: String? = nil
    
    /// Partitions on this storage device
    public var partitions: [StorageDevicePartition]? = nil
}

/**
 The Hardware class contains Computer Inventory information about Hardware.
 */
public class Hardware {
    /// The hardware vendor eg. "Apple"
    public var make: String? = nil
    /// The model
    public var model: String? = nil
    /// Model identifier
    public var modelIdentifier: String? = nil
    /// Operating System
    public var osName: String? = nil
    /// Operating System Version
    public var osVersion: String? = nil
    /// Operating System Build Number
    public var osBuild: String? = nil
    
    public var masterPasswordSet: Bool = false
    
    /// Active directory bound directory
    public var activeDirectoryStatus: String? = nil
    
    public var servicePack: String? = nil
    
    /// Processor manufacturer and model
    public var processorType: String? = nil
    /// Architecture, typically x86_64
    public var processorArchitecture: String? = nil
    /// Speed (in mhz)
    public var processorSpeed: String? = nil
    /// Speed (in mhz)
    public var processorSpeedMhz: String? = nil
    /// Number of physical processors
    public var numberProcessors: Int = 0
    /// Number of processor cores
    public var numberCores: Int = 0
    /// Total RAM size (Mb)
    public var totalRam: Int = 0
    /// Total RAM size (Mb)
    public var totalRamMb: Int = 0
    /// Boot ROM version
    public var bootRom: String? = nil
    /// Bus Speed
    public var busSpeed: String? = nil
    /// Bus Speed in mhz
    public var busSpeedMhz: String? = nil
    /// Battery capacity, or -1 for no battery
    public var batteryCapcity: Int = -1
    /// Cache size
    public var cacheSize: Int = 0
    /// Cache size (in kb)
    public var cacheSizeKb: Int = 0
    /// Available RAM slots
    public var availableRamSlots: Int = 0
    //opticalDrive
    /// Network Interface Link Speeds Available
    public var nicSpeed: String? = nil
    /// SMC Controller firmware version
    public var smcVersion: String? = nil
    public var bleCapable: Bool = false
    
    // institutionalRecoveryKey
    // diskEncryptionConfiguration
    // filevault2Users
    
    public var storage: [StorageDevice]? = nil
}


public class ComputerGeneral {
    
    /// Object Identifier
    public var id: Int = 0
    /// Name
    public var name: String? = nil
    /// MAC Address
    public var macAddress: String? = nil
    /// Alternate MAC Address
    public var altMacAddress: String? = nil
    /// IP Address
    public var ipAddress: String? = nil
    /// Last Reported IP
    public var lastReportedIp: String? = nil
    /// Serial number
    public var serialNumber: String? = nil
    /// Universal device identifier
    public var udid: String? = nil
    /// JAMF Version
    public var jamfVersion: String? = nil
    /// Platform
    public var platform: String? = nil
    
    public var barcode1: String? = nil
    public var barcode2: String? = nil
    
    /// Computer asset tag
    public var assetTag: String? = nil
    
    public class RemoteManagement {
        var managed: Bool = true
        var managementUsername: String? = nil
        var managementPasswordSha256: String? = nil
    }
    
    public var remoteManagement: RemoteManagement? = nil
    
    public var mdmCapable: Bool = false
    //public var mdmCapableUsers: [User]? = nil
    
    public var reportDate: Date? = nil
    public var lastContactTime: Date? = nil
    public var initialEntryDate: Date? = nil
    public var lastCloudBackupDate: Date? = nil
    public var lastEnrolledDate: Date? = nil
    
    // distribution_point
    // sus
    // netboot_server
    
    public var site: Site? = nil
    public var itunesAccountIsActive: Bool = false
}

public class ComputerLocation {
    public var username: String? = nil
    public var realName: String? = nil
    public var emailAddress: String? = nil
    public var position: String? = nil
    public var phone: String? = nil
    public var department: Department? = nil
    public var building: Building? = nil
    public var room: String? = nil
}


public class Computer: JSSResource {
    public var general: ComputerGeneral = ComputerGeneral()
    public var location: ComputerLocation = ComputerLocation()
    
}
