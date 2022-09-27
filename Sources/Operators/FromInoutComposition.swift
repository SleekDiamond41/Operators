import PrecedenceGroups


/// The `FromInoutComposition` operator. Composes a non-mutating function
/// on the left with a mutating function on the right.
public func <>> <A> (_ f: @escaping (inout A) -> Void, _ g: @escaping (A) -> A) -> (inout A) -> Void {
	{ a in
		f(&a)
		a = g(a)
	}
}
