//: [Previous](@previous)
/*:
 # Forward Application (|>)
 Forward Application operator sends a value on the left into a function on the right
 */

import Operators
import SwiftUI

public struct DepColor {
	public var red: UInt8
	public var green: UInt8
	public var blue: UInt8

	public init(red: UInt8, green: UInt8, blue: UInt8) {
		self.red = red
		self.green = green
		self.blue = blue
	}
}

//let dependenciesColor: (SwiftUI.Color) -> DepColor = { swiftUIColor in
//	let uiColor = UIColor(swiftUIColor)
//	let color = uiColor.ciColor
//
//	return color
//}
//>>> { color in
//
//	return DepColor(
//		red: UInt8(color.red * 255),
//		green: UInt8(color.green * 255),
//		blue: UInt8(color.blue * 255)
//	)
//}

1 |> incr


// is equivalent to:
incr(1)

/*:
 This library includes operator overloads for mutator functions that pass by reference (inout).
 */
var mutableNumber = 3
mutableNumber |> mutatingIncr

let result = mutableNumber |> mutatingIncr

// Note: These examples are simplistic. In cases as shown above, it would likely
// be more efficient to simply use the built-in syntax of Swift. However,
// these individual pages exist to show each operator in its simplest form. See
// the final page of this playground for differences in clarity and conciseness
// when composing with these operators versus standard syntax.

//: [Next](@next)
