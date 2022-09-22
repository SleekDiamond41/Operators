import Foundation
import PrecedenceGroups


public func >=> <A, B, C>(_ f: @escaping (A) async -> (B, [String]), _ g: @escaping (B) async -> (C, [String])) -> (A) async -> (C, [String]) {
	return { a in
		let (b, effects) = await f(a)
		let (c, moreEffects) = await g(b)
		return (c, effects + moreEffects)
	}
}

public func >=> <A, B, C>(_ f: @escaping (A) async -> (B, [String]), _ g: @escaping (B) -> (C, [String])) -> (A) async -> (C, [String]) {
	return { a in
		let (b, effects) = await f(a)
		let (c, moreEffects) = g(b)
		return (c, effects + moreEffects)
	}
}

public func >=> <A, B, C>(_ f: @escaping (A) -> (B, [String]), _ g: @escaping (B) async -> (C, [String])) -> (A) async -> (C, [String]) {
	return { a in
		let (b, effects) = f(a)
		let (c, moreEffects) = await g(b)
		return (c, effects + moreEffects)
	}
}

public func >=> <A, B, C>(_ f: @escaping (A) async throws -> (B, [String]), _ g: @escaping (B) async throws -> (C, [String])) -> (A) async throws -> (C, [String]) {
	return { a in
		let (b, effects) = try await f(a)
		let (c, moreEffects) = try await g(b)
		return (c, effects + moreEffects)
	}
}

public func >=> <A, B, C>(_ f: @escaping (A) async throws -> (B, [String]), _ g: @escaping (B) throws -> (C, [String])) -> (A) async throws -> (C, [String]) {
	return { a in
		let (b, effects) = try await f(a)
		let (c, moreEffects) = try g(b)
		return (c, effects + moreEffects)
	}
}

public func >=> <A, B, C>(_ f: @escaping (A) throws -> (B, [String]), _ g: @escaping (B) async throws -> (C, [String])) -> (A) async throws -> (C, [String]) {
	return { a in
		let (b, effects) = try f(a)
		let (c, moreEffects) = try await g(b)
		return (c, effects + moreEffects)
	}
}
