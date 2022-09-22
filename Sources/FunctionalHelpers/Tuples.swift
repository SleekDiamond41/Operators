import Foundation


// MARK: - First
public func first<A, B, T>(_ f: @escaping (A) -> T) -> ((A, B)) -> (T, B) {
	return {
		(f($0.0), $0.1)
	}
}

public func first<A, B, C, T>(_ f: @escaping (A) -> T) -> ((A, B, C)) -> (T, B, C) {
	return {
		(f($0.0), $0.1, $0.2)
	}
}

public func first<A, B, C, D, T>(_ f: @escaping (A) -> T) -> ((A, B, C, D)) -> (T, B, C, D) {
	return {
		(f($0.0), $0.1, $0.2, $0.3)
	}
}


// MARK: - Second
public func second<A, B, T>(_ f: @escaping (B) -> T) -> ((A, B)) -> (A, T) {
	return {
		($0.0, f($0.1))
	}
}

public func second<A, B, C, T>(_ f: @escaping (B) -> T) -> ((A, B, C)) -> (A, T, C) {
	return {
		($0.0, f($0.1), $0.2)
	}
}

public func second<A, B, C, D, T>(_ f: @escaping (B) -> T) -> ((A, B, C, D)) -> (A, T, C, D) {
	return {
		($0.0, f($0.1), $0.2, $0.3)
	}
}


// MARK: - Third
public func third<A, B, C, T>(_ f: @escaping (C) -> T) -> ((A, B, C)) -> (A, B, T) {
	return {
		($0.0, $0.1, f($0.2))
	}
}

public func third<A, B, C, D, T>(_ f: @escaping (C) -> T) -> ((A, B, C, D)) -> (A, B, T, D) {
	return {
		($0.0, $0.1, f($0.2), $0.3)
	}
}
