import Foundation

enum StoreError : Error {
    case Serialization
    case EmptyContent
}

class JSSStore {
    let api: API
    let url: URL
    
    init(api: API, path: String) {
        self.api = api
        self.url = self.api.url.appendingPathComponent(path)
    }
}
