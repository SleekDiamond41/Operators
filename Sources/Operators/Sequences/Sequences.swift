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
		
		return result
	}
}

func batchIndices<C>(batchSize: Int, collection: C) -> [Range<C.Index>] where C: Collection {
	var batchIndices = [Range<C.Index>]()
	
	var lower = collection.startIndex
	var upper = Swift.min(collection.endIndex, collection.index(lower, offsetBy: Int(batchSize)))
	
	while upper < collection.endIndex {
		batchIndices.append(lower..<upper)
		lower = upper
		upper = Swift.min(collection.endIndex, collection.index(upper, offsetBy: Int(batchSize)))
	}
	
	batchIndices.append(lower..<upper)
	
	return batchIndices
}

private let accessQueue = DispatchQueue(label: "Operators.Sequences.mapConcurrent.accessQueue.\(UUID())", target: .global(qos: .userInitiated))

public func mapConcurrent<C, T>(priority: DispatchQoS.QoSClass = .utility, batchSize: UInt = 100, _ transform: @escaping (C.Element) -> T) -> (C) -> ContiguousArray<T> where C: Collection {
	
	{ sourceCollection in
		
		let concurrentWorkerQueue = DispatchQueue.global(qos: priority)
		let batchSize = Swift.max(batchSize, 1)	// prevent infinite looping
		
		var result = ContiguousArray<T?>(repeating: nil, count: sourceCollection.count)
		let group = DispatchGroup()
		
		let batchIndices = batchIndices(batchSize: Int(batchSize), collection: sourceCollection)
		
		for (batchOffset, batchRange) in batchIndices.enumerated() {
			group.enter()
			
			concurrentWorkerQueue.async {
				// do the long-running part of the work
				let batchResults = sourceCollection[batchRange].map(transform)
				
				accessQueue.async {
					let lowerBound = batchOffset * Int(batchSize)
					let upperBound = Swift.min(lowerBound + Int(batchSize), sourceCollection.count)
					
					result[lowerBound..<upperBound] = ArraySlice(batchResults)
					
					group.leave()
				}
			}
		}
		
		group.wait()
		
		assert(result.allSatisfy { $0 != nil }, "failed to transform all elements while waiting for results! Try splitting the operation into smaller groups of collections")
		
		// we know this is safe to cast, since we know all elements exist.
		// Theoriteically it's faster than compact mapping over our results
		return unsafeBitCast(result, to: ContiguousArray<T>.self)
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
