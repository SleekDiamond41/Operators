import Foundation
import UIKit


// MARK: Immutables
public func incr(_ int: Int) -> Int {
    int + 1
}

public func decr(_ int: Int) -> Int {
    int - 1
}

public func square(_ int: Int) -> Int {
    int * int
}

// MARK: Mutations
public func mutatingIncr(_ int: inout Int) {
    int += 1
}



// MARK: Views
public func backgroundStyle(_ view: UIView) {
    view.backgroundColor = .black
}

public func borderStyle(_ view: UIView) {
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 2
}
