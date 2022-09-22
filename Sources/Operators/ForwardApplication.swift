import Foundation
import PrecedenceGroups


public func |> <A, B>(_ a: A, _ f: @escaping (A) -> B) -> B {
	f(a)
}

public func |> <A: AnyObject>(_ a: A, _ f: @escaping (A) -> Void) -> A {
	f(a)
	return a
}

public func |> <A>(_ a: inout A, _ f: (inout A) -> Void) {
	f(&a)
}

@_disfavoredOverload
public func |> <A>(_ a: A, _ f: (inout A) -> Void) -> A {
	var copy = a
	f(&copy)
	return copy
}

public func toInout<T>(_ f: @escaping (T) -> T) -> (inout T) -> Void {
	{ t in
		t = f(t)
	}
}

public func fromInout<T>(_ f: @escaping (inout T) -> Void) -> (T) -> T {
	{ t in
		var copy = t
		f(&copy)
		return copy
	}
}
