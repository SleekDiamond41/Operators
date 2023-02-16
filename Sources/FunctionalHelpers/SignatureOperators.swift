import Foundation


public func curry<A, B, T>(_ f: @escaping (A, B) -> T) -> (A) -> (B) -> T {
	return { a in
		{ b in
			f(a, b)
		}
	}
}

public func curry<A, B, C, T>(_ f: @escaping (A, B, C) -> T) -> (A) -> (B, C) -> T {
	return { a in
		{ b, c in
			f(a, b, c)
		}
	}
}

public func curry<A, B, C, D, T>(_ f: @escaping (A, B, C, D) -> T) -> (A) -> (B, C, D) -> T {
	return { a in
		{ b, c, d in
			f(a, b, c, d)
		}
	}
}

public func curry<A, B, C, D, E, T>(_ f: @escaping (A, B, C, D, E) -> T) -> (A) -> (B, C, D, E) -> T {
	return { a in
		{ b, c, d, e in
			f(a, b, c, d, e)
		}
	}
}

public func uncurry<A, B, T>(_ f: @escaping (A) -> (B) -> T) -> (A, B) -> T {
	return { a, b in
		f(a)(b)
	}
}

public func uncurry<A, B, C, T>(_ f: @escaping (A) -> (B, C) -> T) -> (A, B, C) -> T {
	return { a, b, c in
		f(a)(b, c)
	}
}

public func uncurry<A, B, C, D, T>(_ f: @escaping (A) -> (B, C, D) -> T) -> (A, B, C, D) -> T {
	return { a, b, c, d in
		f(a)(b, c, d)
	}
}

public func uncurry<A, B, C, D, E, T>(_ f: @escaping (A) -> (B, C, D, E) -> T) -> (A, B, C, D, E) -> T {
	return { a, b, c, d, e in
		f(a)(b, c, d, e)
	}
}

public func flip<A, B, T>(_ f: @escaping (A) -> (B) -> T) -> (B) -> (A) -> T {
	return { b in
		{ a in
			f(a)(b)
		}
	}
}

public func flip<A, B, C, T>(_ f: @escaping (A) -> (B, C) -> T) -> (B, C) -> (A) -> T {
	return { b, c in
		{ a in
			f(a)(b, c)
		}
	}
}

public func flip<A, B, C, D, T>(_ f: @escaping (A) -> (B, C, D) -> T) -> (B, C, D) -> (A) -> T {
	return { b, c, d in
		{ a in
			f(a)(b, c, d)
		}
	}
}


//public func zurry<A, B>(_ f: @escaping () -> (A) -> B) -> (A) -> B {
//	return { a in
//		f()(a)
//	}
//}

public func zurry<A, B>(_ f: @escaping (()) -> (A) -> B) -> (A) -> B {
	return { a in
		f(())(a)
	}
}

//public func zurry<A, B, C>(_ f: @escaping (A?) -> (B) -> C) -> (B) -> C {
//	return { b in
//		f(nil)(b)
//	}
//}

public func zurry<A, B, C>(_ a: A) -> (@escaping (A) -> (B) -> C) -> (B) -> C {
	return { block in
		{ b in
			block(a)(b)
		}
	}
}

public func fromInout<Value>(_ f: @escaping (inout Value) -> Void) -> (Value) -> Value {
	{ value in
		var value = value
		f(&value)
		return value
	}
}

public func toInout<Value>(_ f: @escaping (Value) -> Value) -> (inout Value) -> Void {
	{ value in
		value = f(value)
	}
}
