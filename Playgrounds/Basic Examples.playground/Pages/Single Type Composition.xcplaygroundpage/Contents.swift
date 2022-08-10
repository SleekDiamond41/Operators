//: [Previous](@previous)
/*:
 # Single Type Composition (<>)
 Single Type Composition is just like Forward Composition, except it operates only
 on functions with **identical signatures**. This additional rule restricts us, but
 communicates a different intention in the code.
 
 Instead of mapping a value from one type to another, we do things with a single type.
 */

import Operators

(incr <> square)(1)

/*:
 ### Ordering
 We might create a function as below, to perform some complex operation. This is simple enough.
 */

func incrAndSquare(_ num: Int) -> Int {
    let i = num + 1
    return i * i
}

/*:
 However we can't flip the order of these operations without creating a new function.
 We have to duplicate the logic of the steps we just wrote. Once we clean our code,
 we wouldn't know from their bodies that these two functions duplicate logic:
 */
func squareAndIncr(_ num: Int) -> Int {
    (num * num) + 1
}

/*:
 With operators we are rewarded for making very small, simple (testable) functions.
 We can then compose them into more complicated functions, without duplicating our efforts.
 */
(incr <> square)(2)
(square <> incr)(2)


/*:
 ### Styling
 Imagine you have certain styling that you need to keep consistent in your application.
 You might make a base class to implement such styling, but what happens when you need
 one part of that style for a subview, but not the other part? Or if you need both the
 styles of a `BorderedButton` and a `CircularButton`? (the "diamond" inheritance problem)
 
 With composition, we don't have to worry about weird class inheritance. We can apply
 styles whenever we like, to whichever view we like. We can even make free functions of
 compositions, where those will be reused.
 */

import UIKit

func borderStyle(_ view: UIView) {
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 2
}

func roundedCornerStyle(_ view: UIView) {
    view.layer.cornerRadius = 8
}

func primaryContentBackgroundStyle(_ view: UIView) {
    view.backgroundColor = UIColor(red: 10/255, green: 0/255, blue: 200/255, alpha: 1)
}

/// The style for a button that represents a primary action
let primaryButtonStyle = primaryContentBackgroundStyle <> roundedCornerStyle <> borderStyle

let someButton = UIButton()
let someView = UIView()

primaryButtonStyle(someButton)
(borderStyle <> roundedCornerStyle)(someView)

//: [Next](@next)
