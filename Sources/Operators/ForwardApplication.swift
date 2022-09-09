import Foundation


precedencegroup ForwardApplication {
	associativity: left
	higherThan: AssignmentPrecedence
}

infix operator |>: ForwardApplication


public func |> <A, B>(_ a: A, _ f: @escaping (A) -> B) -> B {
	f(a)
}

public func |> <A>(_ a: A, _ f: @escaping (A) -> Void) -> A {
	f(a)
	return a
}

public func |> <A>(_ a: inout A, _ f: @escaping (inout A) -> Void) {
	f(&a)
}

public func |> <A>(_ a: A, _ f: @escaping (inout A) -> Void) -> A {
	var copy = a
	f(&copy)
	return copy
}

final class MyView {
	var backgroundColor: String = ""
	var borderColor: String = ""
	var borderThickness: Double = 0
}

func borderStyle(_ view: MyView) {
}

func someBackgroundStyle(_ view: MyView) {
}

let view = MyView()
|> borderStyle <> someBackgroundStyle
|> get(\.backgroundColor)


