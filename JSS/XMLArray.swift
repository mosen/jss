import Foundation

struct XMLArrayIterator<ElementType>: IteratorProtocol {
    
    let values: XMLArray<ElementType>
    var index: Int = 0
    
    init(values: XMLArray<ElementType>) {
        self.values = values
    }
    
    mutating func next() -> ElementType? {
        let value = self.values.items[self.index]
        
        self.index += 1
        return value
    }
}


// XML Collections can normally be treated as arrays, with the exception that we can't always infer the tag of the collection
// or the tag of each element.
// This type just wraps Array to provide that information.
struct XMLArray<ElementType>: Collection {
    
    var collectionTag: String = "array"
    var itemTag: String = "item"
    var items = [ElementType]()
 
    // Pass-through to underlying array
    var startIndex: Int {
        get {
            return self.items.startIndex
        }
    }
    
    var endIndex: Int {
        get {
            return self.items.endIndex
        }
    }
    
    subscript(index: Int) -> ElementType {
        get {
            return self.items[index]
        }
        
        set(newValue) {
            self.items[index] = newValue
        }
    }
    
    func index(after i: Int) -> Int {
        return self.items.index(after: i)
    }
}

// MARK:- Sequence
extension XMLArray: Sequence {
    
    func makeIterator() -> XMLArrayIterator<ElementType> {
        return XMLArrayIterator<ElementType>(values: self)
    }
    
}

// MARK:- IndexableBase
//extension XMLArray: Indexable {
//    
//}

