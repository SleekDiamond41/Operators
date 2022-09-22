import Foundation
import PrecedenceGroups


public func <<< <A, B, C>(g: @escaping (B) async -> C, f: @escaping (A) async -> B) -> (A) async -> C {
	return { a in
		await g(f(a))
	}
}

public func <<< <A, B, C>(g: @escaping (B) async -> C, f: @escaping (A) -> B) -> (A) async -> C {
	return { a in
		await g(f(a))
	}
}

public func <<< <A, B, C>(g: @escaping (B) -> C, f: @escaping (A) async -> B) -> (A) async -> C {
	return { a in
		await g(f(a))
	}
}
