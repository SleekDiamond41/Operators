import Foundation
import PrecedenceGroups


public func <><A>(_ f: @escaping (A) async -> A, _ g: @escaping (A) async -> A) -> (A) async -> A {
	f >>> g
}

public func <><A>(_ f: @escaping (A) async -> A, _ g: @escaping (A) -> A) -> (A) async -> A {
	f >>> g
}

public func <><A>(_ f: @escaping (A) -> A, _ g: @escaping (A) async -> A) -> (A) async -> A {
	f >>> g
}

public func <><A: AnyObject>(_ f: @escaping (A) async -> Void, _ g: @escaping (A) async -> Void) -> (A) async -> Void {
	{ a in
		await f(a)
		await g(a)
	}
}

public func <><A: AnyObject>(_ f: @escaping (A) async -> Void, _ g: @escaping (A) -> Void) -> (A) async -> Void {
	{ a in
		await f(a)
		g(a)
	}
}

public func <><A: AnyObject>(_ f: @escaping (A) -> Void, _ g: @escaping (A) async -> Void) -> (A) async -> Void {
	{ a in
		f(a)
		await g(a)
	}
}

public func <><A>(_ f: @escaping (inout A) async -> Void, _ g: @escaping (inout A) async -> Void) -> (inout A) async -> Void {
	{ a in
		await f(&a)
		await g(&a)
	}
}

public func <><A>(_ f: @escaping (inout A) async -> Void, _ g: @escaping (inout A) -> Void) -> (inout A) async -> Void {
	{ a in
		await f(&a)
		g(&a)
	}
}

public func <><A>(_ f: @escaping (inout A) -> Void, _ g: @escaping (inout A) async -> Void) -> (inout A) async -> Void {
	{ a in
		f(&a)
		await g(&a)
	}
}
