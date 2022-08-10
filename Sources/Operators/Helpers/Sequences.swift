import Foundation


// MARK: - Sequences
public func compactMap<S, T>(_ transform: @escaping (S.Element) -> T?) -> (S) -> [T] where S: Sequence {
	{ s in s.compactMap(transform) }
}

public func map<S, T>(_ transform: @escaping (S.Element) -> T) -> (S) -> [T] where S: Sequence {
	{ s in
		var result = [T]()
		result.reserveCapacity(s.underestimatedCount)
		
		for item in s {
			result.append(transform(item))
		}
//		s.map(transform)
		
		return result
	}
}


public func mapConcurrent<C, T>(priority: DispatchQoS.QoSClass = .utility, _ transform: @escaping (C.Element) -> T) -> (C) -> [T] where C: Collection {
	
	{ collection in
		
		let accessQueue = DispatchQueue(label: "Operators.Sequences.mapConcurrent.accessQueue.\(UUID())", target: .global(qos: .userInitiated))
		let concurrentWorkerQueue = DispatchQueue.global(qos: priority)
		
		var result = ContiguousArray<T?>(repeating: nil, count: collection.count)
		let group = DispatchGroup()
		
		for (index, item) in collection.enumerated() {
			group.enter()
			
			concurrentWorkerQueue.async {
				let newItem = transform(item)
				
				accessQueue.async {
					result[index] = newItem
					group.leave()
				}
			}
		}
		
		group.wait()
		
		assert(result.allSatisfy { $0 != nil }, "failed to transform all elements while waiting for results! Try splitting the operation into smaller groups of collections")
		
		// we know this is safe to cast, since we know all elements exist.
		// Theoriteically it's faster than compact mapping over our results
		return unsafeBitCast(result, to: [T].self)
	}
}

public func reduce<S, T>(_ initialValue: T, _ nextPartialResult: @escaping (T, S.Element) -> T) -> (S) -> T where S: Sequence {
	{ s in s.reduce(initialValue, nextPartialResult) }
}


// MARK: - Optionals


public func flatMap<R, T>(_ transform: @escaping (R) -> T?) -> (R?) -> T? {
	{ r in r.flatMap(transform) }
}

public func map<R, T>(_ transform: @escaping (R) -> T) -> (R?) -> T? {
	{ r in r.map(transform) }
}
