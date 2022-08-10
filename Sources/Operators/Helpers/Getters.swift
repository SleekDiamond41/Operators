import Foundation


public func get<Root, Value>(_ getter: @escaping (Root) -> Value) -> (Root) -> Value {
	getter
}
