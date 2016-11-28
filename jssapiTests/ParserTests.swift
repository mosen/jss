import XCTest

class ParserTests: XCTestCase {

    let package: Package = {
        let pkg = Package(name: "mypackage", filename:"MyPackage.dmg")
        return pkg
    }()
    
    let packageXml: String = "<package>" +
    "<id>1</id>" +
    "<name>mypackage</name>" +
    "<category>A Category</category>" +
    "<filename>MyPackage.dmg</filename>" +
    "<info>my package</info>" +
    "<notes>my package</notes>" +
    "<priority>10</priority>" +
    "<reboot_required>false</reboot_required>" +
    "<fill_user_template>false</fill_user_template>" +
    "<fill_existing_users>false</fill_existing_users>" +
    "<boot_volume_required>false</boot_volume_required>" +
    "<allow_uninstalled>false</allow_uninstalled>" +
    "<os_requirements>10.10.x</os_requirements>" +
    "<required_processor>x86</required_processor>" +
    "<switch_with_package>Do Not Install</switch_with_package>" +
    "<install_if_reported_available>false</install_if_reported_available>" +
    "<reinstall_option>Do Not Reinstall</reinstall_option>" +
    "<triggering_files/>" +
    "<send_notification>false</send_notification>" +
    "</package>"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMirrorParser() {
        let parser = XMLParser(data: self.packageXml.data(using: .utf8)!)
        let parserDelegate = MirrorParser(reflecting: self.package)
        parser.delegate = parserDelegate

        parser.parse()
        dump(self.package)
    }
    
    func testXMLCoder() {
        let xml = JSSXMLKeyedArchiver.archivedXML(withRootObject: self.package, rootTag: "package")
        print(xml.xmlString)
    }
}
