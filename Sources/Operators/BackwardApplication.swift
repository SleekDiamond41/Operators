import Foundation
import PrecedenceGroups


public func <| <A, B>(_ f: @escaping (A) -> B, _ a: A) -> B {
	f(a)
}

public func <| <A: AnyObject>(_ f: @escaping (A) -> Void, _ a: A) -> A {
	f(a)
	return a
}
