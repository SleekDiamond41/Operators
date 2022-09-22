import Foundation
import PrecedenceGroups


public func <| <A, B>(_ f: @escaping (A) async -> B, _ a: A) async -> B {
	await f(a)
}

public func <| <A: AnyObject>(_ f: @escaping (A) async -> Void, _ a: A) async -> A {
	await f(a)
	return a
}
