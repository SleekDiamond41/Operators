import Foundation


public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
	return { a in
		{ b in
			f(a, b)
		}
	}
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
	return { b in
		{ a in
			f(a)(b)
		}
	}
}


//public func zurry<A, B>(_ f: @escaping () -> (A) -> B) -> (A) -> B {
//	return { a in
//		f()(a)
//	}
//}
//
//public func zurry<A, B>(_ f: @escaping (()) -> (A) -> B) -> (A) -> B {
//	return { a in
//		f(())(a)
//	}
//}
//
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
