import Foundation

// <>
precedencegroup SingleTypeComposition {
	associativity: left
	higherThan: EffectfulComposition
	lowerThan: RangeFormationPrecedence
}

// >=>
precedencegroup EffectfulComposition {
	associativity: left
	higherThan: BackwardComposition
	lowerThan: RangeFormationPrecedence
}

// <<<
precedencegroup BackwardComposition {
	associativity: left
	higherThan: ForwardComposition
	lowerThan: RangeFormationPrecedence
}

// >>>
precedencegroup ForwardComposition {
	associativity: left
	higherThan: ToInoutComposition
	lowerThan: RangeFormationPrecedence
}

// <>>
precedencegroup FromInoutComposition {
	higherThan: ToInoutComposition
	lowerThan: RangeFormationPrecedence
}

// <<>
precedencegroup ToInoutComposition {
	higherThan: BackwardApplication
	lowerThan: RangeFormationPrecedence
}

// |>>
precedencegroup MutatingForwadApplication {
	associativity: left
	higherThan: BackwardApplication
	lowerThan: RangeFormationPrecedence
}

// <|
precedencegroup BackwardApplication {
	associativity: left
	higherThan: ForwardApplication
	lowerThan: RangeFormationPrecedence
}

// |>
precedencegroup ForwardApplication {
	associativity: left
	higherThan: AssignmentPrecedence
	lowerThan: RangeFormationPrecedence
}
