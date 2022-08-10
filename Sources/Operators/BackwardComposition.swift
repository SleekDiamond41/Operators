import Foundation


precedencegroup BackwardComposition {
	associativity: left
	higherThan: ForwardComposition
}

infix operator <<<: BackwardComposition


public func <<< <A, B, C>(g: @escaping (B) -> C, f: @escaping (A) -> B) -> (A) -> C {
	return { a in
		g(f(a))
	}
}
