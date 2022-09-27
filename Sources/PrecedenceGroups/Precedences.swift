import Foundation

// <>
precedencegroup SingleTypeComposition {
	associativity: left
	higherThan: EffectfulComposition
}

// >=>
precedencegroup EffectfulComposition {
	associativity: left
	higherThan: BackwardComposition
}

// <<<
precedencegroup BackwardComposition {
	associativity: left
	higherThan: ForwardComposition
}

// >>>
precedencegroup ForwardComposition {
	associativity: left
	higherThan: ToInoutComposition
}

// <>>
precedencegroup FromInoutComposition {
	higherThan: ToInoutComposition
}

// <<>
precedencegroup ToInoutComposition {
	higherThan: BackwardApplication
}

// |>>
precedencegroup MutatingForwadApplication {
	associativity: left
	higherThan: BackwardApplication
}

// <|
precedencegroup BackwardApplication {
	associativity: left
	higherThan: ForwardApplication
}

// |>
precedencegroup ForwardApplication {
	associativity: left
	higherThan: AssignmentPrecedence
}
