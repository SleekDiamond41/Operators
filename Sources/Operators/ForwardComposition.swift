import Foundation


precedencegroup ForwardComposition {
	associativity: left
	higherThan: ForwardApplication
}

infix operator >>>: ForwardComposition


public func >>> <A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
	return { g(f($0)) }
}
