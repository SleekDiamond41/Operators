//: [Previous](@previous)
import Operators
import UIKit


// consider applying a series of styles to a view with standard syntax:
let standardSyntaxView = UIView()
borderStyle(standardSyntaxView)
backgroundStyle(standardSyntaxView)

// versus operators:
let operatorView = UIView()
|> borderStyle <> backgroundStyle <> set(\.layer.masksToBounds, true)

/*
 The former strategy is mechanical:
     - CREATE View
     - DO border styling to View
     - DO background styling to View
 
 It also leaves ambiguity as to what steps are necessary to configure the view.
 Consider a view/controller with a series of styling in `viewDidLoad`, but over
 time successive changes from developers separate the styling, perhaps inserting
 logging statements or posting notifications in NotificationCenter.
 
 The latter reads as a human might say a sentence:
 - "Create a view, style it with a border, then a background, then make sure it masks to bounds"
 
 The program is never given access to the View before it is fully configured and ready to consume.
 (Note that due to order of operations, the functions are composed into a single
 function, which is then applied to the value that's applied in.)
 */


// TODO: complete this example
/*
 Composing styles to create a new style
 */
let primaryButtonStyle: (UIButton) -> Void = set(\.layer.cornerRadius, 20)
<> set(\.backgroundColor, .blue)
<> set(\.font, UIFont.preferredFont(forTextStyle: .title3))


//: [Next](@next)
