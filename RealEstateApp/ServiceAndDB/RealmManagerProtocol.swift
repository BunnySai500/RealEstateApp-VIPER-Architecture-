 

import Foundation
import Realm
import RealmSwift

protocol RealmManagerProtocol {
    func object<T: Object>() -> T?
    func object<T: Object>(_ key: Any?) -> T?
    func object<T: Object>(_ predicate: (T) -> Bool) -> T?
    
    func objects<T: Object>() -> [T]
    func objects<T: Object>(_ predicate: (T) -> Bool) -> [T]
    
    @discardableResult func write<T: Object>(_ object: T?) -> Bool
    @discardableResult func write<T: Object>(_ objects: [T]?) -> Bool
    
    @discardableResult func update(_ block: () -> ()) -> Bool
    @discardableResult func delete<T: Object>(_ object: T) -> Bool
    
    @discardableResult func flush() -> Bool
}
