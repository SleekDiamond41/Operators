//: [Previous](@previous)

import _Concurrency
import Foundation

struct NetworkClient {
	var getSomething: () async -> String
}

extension NetworkClient {
	static let live = NetworkClient(
		getSomething: {
			let url = URL(string: "https://www.something.com/")!
			var request = URLRequest(url: url)
			
			do {
				let result = try await URLSession.shared.data(for: request)
				return String(data: result.0, encoding: .utf8)!
				
			} catch {
				return "FAIL"
			}
		}
	)
	
	static let noop = NetworkClient(
		getSomething: {
			return "EMPTY"
		}
	)
}

Task {
	let result = await NetworkClient.live.getSomething()
	print(result)
}

let things = "things"
let temp = "Hello, World \(things)"



print(temp)

//: [Next](@next)
