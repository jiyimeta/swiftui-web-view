protocol Modifiable {}

extension Modifiable {
    func modifying<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
        var new = self
        new[keyPath: keyPath] = value
        return new
    }

    func modifying<T>(_ keyPath: WritableKeyPath<Self, T>, _ block: (T) -> T) -> Self {
        var new = self
        new[keyPath: keyPath] = block(self[keyPath: keyPath])
        return new
    }
}
