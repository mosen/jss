import Foundation





class JSSStore {
    let api: API
    var paths: Dictionary<ResourcePaths,String> = [:]
    
    init(api: API, paths: Dictionary<ResourcePaths,String>?) {
        self.api = api
        if let pathsv = paths {
            self.paths = pathsv
        }
    }
}
