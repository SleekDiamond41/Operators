import Combine
import Foundation
import XCTest
@testable import Operators

final class OperatorsTests: XCTestCase {
	
	func testExample() throws {
	}
	
	func getThings() async -> [Int] {
		try! await Task.sleep(nanoseconds: 1_000_000_000)
		return [1, 2, 3]
	}
	
	func getThingsPublisher() -> AnyPublisher<Int, Never> {
		[1, 2, 3].publisher
			.flatMap { num in
				Just(num)
					.delay(for: .init(integerLiteral: num), scheduler: ImmediateScheduler.shared)
			}
			.eraseToAnyPublisher()
	}
	
	func testSomeAsyncStuffNoExpectations() async {
		
		var actual = [Int]()
		let expected = [1, 2, 3]
		
		for thing in await getThings() {
			actual.append(thing)
		}
		
		XCTAssertEqual(actual, expected)
	}
	
	@available(macOS 12.0, *)
	func testSomeAsyncStuff_withPublishers() async {
		var actual = [Int]()
		let expected = [1, 2, 3]
		
		for await thing in getThingsPublisher().values {
			actual.append(thing)
		}
		
		print(actual)
		XCTAssertEqual(actual, expected)
	}
	
	func testSomeAsyncStuff() async {
		
		let exp = expectation(description: "expected to wait 1 second")
		Task {
			try! await Task.sleep(nanoseconds: 1_000_000_000)
			exp.fulfill()
		}
		
		wait(for: [exp], timeout: 5)
	}
}
