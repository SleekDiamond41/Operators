import XCTest
import AsyncOperators
import Operators

struct Person: Encodable {
	struct Address: Encodable {
		let street = "123 Main St"
		let city = "Townsville"
		let state = "Confusion"
	}
	
	let firstName = "Johnny"
	let lastName = "Appleseed"
	let agge = 29
	let address = Address()
}


final class ConcurrentMapPerformanceTests: XCTestCase {
	
	let sourceData: [Person] = Array(repeating: Person(), count: 100_000)
	let transform: (Person) -> Data = { person in
		let encoder = JSONEncoder()
		let data  = try! encoder.encode(person)
		return data
	}
	
	func testTaskConcurrentMap() {
		self.measure {
			let exp = expectation(description: "expected to complete stuff")
			Task {
				let results = await mapConcurrent(batchSize: .large, transform)(sourceData)
				
				print(results.first!.count)
				exp.fulfill()
			}
			self.wait(for: [exp], timeout: 100)
		}
	}
	
	func testStandardConcurrentMap() {
		self.measure {
			let results = Operators.mapConcurrent(batchSize: 1023, transform)(sourceData)
				
			print(results.first!.count)
		}
	}
	
	func testStandardMap() {
		self.measure {
			let results = Operators.map(transform)(sourceData)
				
			print(results.first!.count)
		}
	}
}
