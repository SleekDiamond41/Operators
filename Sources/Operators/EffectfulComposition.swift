import Foundation


precedencegroup EffectfulComposition {
	associativity: left
	higherThan: BackwardComposition
}

infix operator >=>: EffectfulComposition


public func >=> <A, B>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> Void) -> (A) -> B {
	return { a in
		let b = f(a)
		g(b)
		return b
	}
}
