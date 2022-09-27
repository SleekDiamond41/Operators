import Foundation
import PrecedenceGroups


public func |> <A, B>(_ a: A, _ f: @escaping (A) -> B) -> B {
	f(a)
}

public func |> <A: AnyObject>(_ a: A, _ f: @escaping (A) -> Void) -> A {
	f(a)
	return a
}
