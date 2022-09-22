import Foundation
import PrecedenceGroups


public func >>> <A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
	return { g(f($0)) }
}

// MARK: Error Handling
public func >>> <A, B, C>(_ f: @escaping (A) throws -> B, _ g: @escaping (B) throws -> C) -> (A) throws -> C {
	return { try g(f($0)) }
}

public func >>> <A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) throws -> C) -> (A) throws -> C {
	return { try g(f($0)) }
}

public func >>> <A, B, C>(_ f: @escaping (A) throws -> B, _ g: @escaping (B) -> C) -> (A) throws -> C {
	return { try g(f($0)) }
}
