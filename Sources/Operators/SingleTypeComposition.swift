import Foundation
import PrecedenceGroups


public func <><A>(_ f: @escaping (A) -> A, _ g: @escaping (A) -> A) -> (A) -> A {
	f >>> g
}

public func <><A: AnyObject>(_ f: @escaping (A) -> Void, _ g: @escaping (A) -> Void) -> (A) -> Void {
	{ a in
		f(a)
		g(a)
	}
}

public func <><A>(_ f: @escaping (inout A) -> Void, _ g: @escaping (inout A) -> Void) -> (inout A) -> Void {
	{ a in
		f(&a)
		g(&a)
	}
}
