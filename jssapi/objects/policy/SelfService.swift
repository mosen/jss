import Foundation

class SelfServiceCategory: NSCoding {
    var id: Int = 0
    var name: String? = nil
    var displayIn: Bool = true
    var featureIn: Bool = false
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.displayIn, forKey: "display_in")
        aCoder.encode(self.featureIn, forKey: "feature_in")
    }
}

class SelfServiceIcon: NSCoding {
    var id: Int = 0
    var filename: String? = nil
    var uri: String? = nil
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.filename, forKey: "filename")
        aCoder.encode(self.uri, forKey: "uri")
    }
}

class SelfService: NSCoding {
    var useForSelfService: Bool = true
    var installButtonText: String? = nil
    var selfServiceDescription: String? = nil
    var forceUsersToViewDescription: Bool = false
    var selfServiceIcon: SelfServiceIcon? = nil
    var featureOnMainPage: Bool = false
    var selfServiceCategories: [SelfServiceCategory]? = nil
    
    // MARK:- NSCoding
    // Don't care about decoding
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.useForSelfService, forKey: "use_for_self_service")
        aCoder.encode(self.installButtonText, forKey: "install_button_text")
        aCoder.encode(self.selfServiceDescription, forKey:"self_service_description")
        aCoder.encode(self.forceUsersToViewDescription, forKey:"force_users_to_view_description")
        aCoder.encode(self.selfServiceIcon, forKey:"self_service_icon")
        aCoder.encode(self.featureOnMainPage, forKey:"feature_on_main_page")
        aCoder.encode(self.selfServiceCategories, forKey:"self_service_categories")
    }
}
