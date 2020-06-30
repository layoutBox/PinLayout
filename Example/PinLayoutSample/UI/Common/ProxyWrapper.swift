import Foundation

@propertyWrapper
public struct Proxy<Value, EnclosingSelf> {
    private let keyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>

    public init(_ keyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>) {
        self.keyPath = keyPath
    }

    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }

    public static subscript(
        _enclosingInstance observed: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            let storageValue = observed[keyPath: storageKeyPath]
            let value = observed[keyPath: storageValue.keyPath]
            return value
        }
        set {
            let storageValue = observed[keyPath: storageKeyPath]
            observed[keyPath: storageValue.keyPath] = newValue
        }
    }
}
