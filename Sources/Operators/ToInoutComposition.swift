import PrecedenceGroups


public func ><> <A> (_ f: @escaping (A) -> A, _ g: @escaping (inout A) -> Void) -> (A) -> A {
	{ a in
		var result = f(a)
		g(&result)
		return result
	}
}
