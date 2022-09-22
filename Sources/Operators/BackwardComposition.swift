import Foundation
import PrecedenceGroups


public func <<< <A, B, C>(g: @escaping (B) -> C, f: @escaping (A) -> B) -> (A) -> C {
	return { a in
		g(f(a))
	}
}
