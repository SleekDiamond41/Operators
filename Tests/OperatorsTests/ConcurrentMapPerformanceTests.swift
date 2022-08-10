import XCTest
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
	
	let sourceData: [Person] = Array(repeating: Person(), count: 10_000)
	let transform: (Person) -> Data = { person in
		let encoder = JSONEncoder()
		let data  = try! encoder.encode(person)
		return data
	}
	
	func testStandardMap() {
		self.measure {
			let results = sourceData.map(transform)
			print(results.first!.count)
		}
	}
	
	func testPureFunctionMap() {
		self.measure {
			let results = sourceData |> map(transform)
			print(results)
		}
	}
	
	func testConcurrentMap() {
		self.measure {
			let results = sourceData |> mapConcurrent(transform)
			print(results)
		}
	}
}
