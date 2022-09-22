@testable import Operators
import XCTest

final class BatchingTests: XCTestCase {
	
	func testBasicBatch() {
		let collection = [1, 2, 3, 4, 5, 6]
		let indices = batchIndices(batchSize: 3, collection: collection)
		
		let expectedIndices: [Range<Int>] = [
			0..<3,
			3..<6,
		]
		
		XCTAssertEqual(indices, expectedIndices)
	}
}
