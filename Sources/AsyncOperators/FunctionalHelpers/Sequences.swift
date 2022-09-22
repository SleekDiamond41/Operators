import Foundation

/// Maps over a sequence, yielding control between batches, if possible.
///
/// Use `BatchSize.noBatching` to prevent yielding.
public func map<S, T>(batchSize batch: BatchSize = .medium, _ transform: @escaping (S.Element) -> T) -> (S) async -> [T] where S: Sequence {
	{ s in
		var result = [T]()
		result.reserveCapacity(s.underestimatedCount)
		
		await batch.perform(on: s, into: &result) { item, partial in
			partial.append(transform(item))
		}
		
		return result
	}
}

/// Filters over a sequence, yielding control between batches, if possible.
///
/// Use `BatchSize.noBatching` to prevent yielding.
public func filter<S>(batchSize batch: BatchSize = .medium, _ isIncluded: @escaping (S.Element) -> Bool) -> (S) async -> [S.Element] where S: Sequence {
	{ s in
		var result = [S.Element]()
		result.reserveCapacity(s.underestimatedCount / 2)
		
		await batch.perform(on: s, into: &result) { item, partial in
			if isIncluded(item) {
				partial.append(item)
			}
		}
		
		return result
	}
}

/// Reduces over a sequence, yielding control between batches, if possible.
///
/// Use `BatchSize.noBatching` to prevent yielding.
public func reduce<S, T>(batchSize batch: BatchSize = .medium, _ initialValue: T, _ nextPartialResult: @escaping (T, S.Element) -> T) -> (S) async -> T where S: Sequence {
	{ s in
		var result = initialValue
		
		await batch.perform(on: s, into: &result) { item, partial in
			partial = nextPartialResult(partial, item)
		}
		
		return result
	}
}

/// Compact Maps over a sequence, yielding control between batches, if possible.
///
/// Use `BatchSize.noBatching` to prevent yielding.
public func compactMap<S, T>(batchSize batch: BatchSize = .medium, _ transform: @escaping (S.Element) -> T?) -> (S) async -> [T] where S: Sequence {
	{ s in
		var result = [T]()
		result.reserveCapacity(s.underestimatedCount / 2)
		
		await batch.perform(on: s, into: &result) { item, partial in
			if let happyItem = transform(item) {
				partial.append(happyItem)
			}
		}
		
		return result
	}
}


/// Maps over all elements of a sequence, performing batches in parallel when possible
public func mapConcurrent<C, T>(priority: TaskPriority? = nil, batchSize batch: BatchSize = .medium, _ transform: @escaping (C.Element) -> T) -> (C) async -> [T] where C: Collection {
	{ collection in
		await withTaskGroup(of: [T].self, returning: [T].self) { group in
			let batchIndices = batchIndices(batchSize: batch.rawValue, collection: collection)
			
			for range in batchIndices {
				group.addTask(priority: priority) {
					collection[range].map(transform)
				}
			}
			
			return await group.reduce([], +)
		}
	}
}

// MARK: - Helpers

public struct BatchSize {
	let rawValue: Int
	
	public static let small 			= BatchSize(rawValue: 63)
	public static let medium 			= BatchSize(rawValue: 255)
	public static let large 			= BatchSize(rawValue: 1023)
	public static let noBatching 	= BatchSize(rawValue: .max)
	
	/// Iterates over a sequence in appropriate batches, collecting results into some result type.
	///
	/// This function yields control between batches, to give the system time to address higher priority tasks.
	func perform<S: Sequence, T>(on s: S, into partial: inout T, action: @escaping (S.Element, inout T) -> Void) async {
		var iterator = s.makeIterator()
		
		whileLoop: while let firstElement = iterator.next() {
			action(firstElement, &partial)
		
			for _ in 0..<rawValue {
				guard let next = iterator.next() else {
					break whileLoop
				}
				action(next, &partial)
			}
			
			// allow someone else time to do stuff.
			// Effectively, we perform our work in batches.
			await Task.yield()
		}
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
