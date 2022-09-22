import Foundation
import PrecedenceGroups


public func >=> <A, B, C>(_ f: @escaping (A) -> (B, [String]), _ g: @escaping (B) -> (C, [String])) -> (A) -> (C, [String]) {
	return { a in
		let (b, effects) = f(a)
		let (c, moreEffects) = g(b)
		return (c, effects + moreEffects)
	}
}

// MARK: - Optionals

public func >=> <A, B, C>(_ f: @escaping (A) -> B?, _ g: @escaping (B) -> C?) -> (A) -> C? {
	return { a in
		f(a).flatMap(g)
	}
}

public func >=> <A, B, C>(_ f: @escaping (A) -> B?, _ g: @escaping (B) -> C) -> (A) -> C? {
	return { a in
		f(a).map(g)
	}
}

// MARK: - Arrays
public func >=> <A, B, C>(_ f: @escaping (A) -> [B], _ g: @escaping (B) -> [C]) -> (A) -> [C] {
	return { a in
		f(a).flatMap(g)
	}
}
