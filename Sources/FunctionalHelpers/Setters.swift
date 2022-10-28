import Foundation


// MARK: - Value Types
public func set<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>, _ mutation: @escaping (inout Value) -> Void) -> (inout Root) -> Void {
	{ root in
		mutation(&root[keyPath: keyPath])
	}
}

public func set<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>, _ value: Value) -> (inout Root) -> Void {
	set(keyPath, { $0 = value })
}

/// The compiler has trouble using KeyPaths to optionals when the `value` is a non-optional
/// (likely because the types don't quite line up) so we provide an explicit overload to resolve ambiguity.
/// 
public func set<Root, Value>(_ keyPath: WritableKeyPath<Root, Value?>, _ value: Value?) -> (inout Root) -> Void {
	set(keyPath, { $0 = value })
}

public func set<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>, _ mutation: @escaping (inout Value) -> Void) -> (Root) -> Root {
	{ root in
		var root = root
		mutation(&root[keyPath: keyPath])
		return root
	}
}

public func set<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>, _ value: Value) -> (Root) -> Root {
	set(keyPath, { $0 = value })
}


// MARK: - Reference Types
public func set<Root, Value>(_ keyPath: ReferenceWritableKeyPath<Root, Value>, _ mutation: @escaping (inout Value) -> Void) -> (Root) -> Void {
	{ root in
		mutation(&root[keyPath: keyPath])
	}
}

public func set<Root, Value>(_ keyPath: ReferenceWritableKeyPath<Root, Value>, _ value: Value) -> (Root) -> Void {
	set(keyPath, { $0 = value })
}

/// The compiler has trouble using KeyPaths to optionals when the `value` is a non-optional
/// (likely because the types don't quite line up) so we provide an explicit overload to resolve ambiguity.
///
public func set<Root, Value>(_ keyPath: ReferenceWritableKeyPath<Root, Value?>, _ value: Value?) -> (Root) -> Void {
	set(keyPath, { $0 = value })
}
