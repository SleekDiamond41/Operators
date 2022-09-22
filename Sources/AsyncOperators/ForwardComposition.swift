import Foundation
import PrecedenceGroups


public func >>> <A, B, C>(_ f: @escaping (A) async -> B, _ g: @escaping (B) async -> C) -> (A) async -> C {
	return {
		await g(f($0))
	}
}

public func >>> <A, B, C>(_ f: @escaping (A) async -> B, _ g: @escaping (B) -> C) -> (A) async -> C {
	return {
		await g(f($0))
	}
}

public func >>> <A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) async -> C) -> (A) async -> C {
	return {
		await g(f($0))
	}
}

// MARK: Error Handling

public func >>> <A, B, C>(_ f: @escaping (A) async throws -> B, _ g: @escaping (B) async throws -> C) -> (A) async throws -> C {
	return {
		try await g(f($0))
	}
}

public func >>> <A, B, C>(_ f: @escaping (A) async throws -> B, _ g: @escaping (B) throws -> C) -> (A) async throws -> C {
	return {
		try await g(f($0))
	}
}

public func >>> <A, B, C>(_ f: @escaping (A) throws -> B, _ g: @escaping (B) async throws -> C) -> (A) async throws -> C {
	return {
		try await g(f($0))
	}
}
