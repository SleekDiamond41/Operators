//: [Previous](@previous)
/*:
 # Forward Composition (>>>)
 
 Forward Composition is extremely powerful. It creates a function
 that maps from A -> C, given functions that map A -> B and B -> C
 */

import Operators

(incr >>> String.init)(2)

/*:
 These can be chained together, and even used directly with closures.
 */

let operation = incr >>> String.init >>> { $0.count }
operation(3)

/*:
 ## Examples with Map
 The `Sequence.map(_:)` operation works by allocating a new array of T elements, then turning each of the current elements into Ts, and putting them in the new array.
 
 Consider a process that requires multiple steps. These could be implemented with:
 - sequental calls to `Sequence.map(_:)`
 - expanding a single map block to do both steps
 - composing functions to a single map block
 */

let people = getPeople()

/*:
 ### Sequential Calls
 This performs very poorly, especially as we add more steps. Each step requires allocating
 a new array and storing the results of a single step, rather than performing multiple steps at once.
 
 However, it reads very clean:
 - "for the people, take their age, categorize the age groups, and get the appropriate message"
 */

let a = people
    .map(\.age)
    .map(AgeGroup.init)
    .map(message(for:))

/*:
 ### Expanding a single block
 This performs much better at scale, but now we can't read straight through the code.
 Notice how we have to reverse the way we think about the process:
 
 - "for all the people, get the appropriate message for the age group of the person's age"
 
 As this block grows in complexity we have to remember longer and longer that we're dealing with a Person,
 and we lose sight of what we're trying to create. As we move from left to right we work backwards through
 what we want to how to get it, but "how we get it" is the left side. It's like saying "I will do work by
 sitting at my desk after driving to the office with the car keys of me."
 
 This can also trick us into writing functions that take in more state than they need, making them more
 difficult to test and reuse.
 */

let b = people.map { message(for: AgeGroup($0.age)) }

/*:
 Of course, nstead of using a pure function for the message we could use a computed property on
 the AgeGroup. This saves us a few keystrokes, but makes the block even more confusing to read:
 
 - "for all the people, categorize their group, based on their age, and get the message"
 
 This practice also makes it more difficult to write consistent code. We can write a function
 to
 */

let b2 = people.map { AgeGroup($0.age).message }

/*:
 ### Forward Composing
 This performs just as well as expanding a single block, but we get to read it like a human again:
 
 - "for all the people, take their age, categorize by age groups, and get the appropriate message"
 */

let c = people.map(\.age >>> AgeGroup.init >>> message(for:))

/*:
 This library also provides pure functions for the standard Sequence operations... try them out!
 Note that the free function `map(_:)` doesn't operate on anything... that function _returns a function_
 that will do the transfomations you described.
 
 We even include a `mapConcurrent(_:)` function for transforming elements of a Sequence! Note that
 you get more performance improvements with more cores available and many more elements to transform.
 Using `mapConcurrent(_:)` on Sequences of fewer than 50 or so elements may actually perform more
 slowly than a simple `map(_:)`, as we lose more time context switching than we gain from parallel operation.
 */

//func getMessages(_ people: [Person]) -> [String] {
//	people
//			.map(\.age)
//			.map(AgeGroup.init)
//			.map(message(for:))
//}

let getMessages: ([Person]) -> [String] = map(\.age >>> AgeGroup.init >>> message(for:))
let bonus = people |> map(\.age >>> AgeGroup.init >>> message(for:))
let bonusConcurrent = people |> mapConcurrent(\.age >>> AgeGroup.init >>> message(for:))

//: [Next](@next)
