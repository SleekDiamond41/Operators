import Foundation
import PrecedenceGroups

public func |> <A, B>(_ a: A, _ f: @escaping (A) async -> B) async -> B {
	await f(a)
}

public func |> <A, B>(_ a: A, _ f: @escaping (A) async throws -> B) async throws -> B {
	try await f(a)
}

public func |> <A>(_ a: A, _ f: @escaping (A) async -> Void) async -> A {
	await f(a)
	return a
}

public func |> <A>(_ a: A, _ f: @escaping (A) async throws -> Void) async throws -> A {
	try await f(a)
	return a
}
