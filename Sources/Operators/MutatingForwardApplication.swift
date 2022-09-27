import PrecedenceGroups


public func |>><A>(_ a: inout A, _ f: @escaping (inout A) -> Void) {
	f(&a)
}
