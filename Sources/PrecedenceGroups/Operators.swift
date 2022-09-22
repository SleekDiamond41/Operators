import Foundation

infix operator <>: SingleTypeComposition

infix operator >=>: EffectfulComposition

infix operator <<<: BackwardComposition

infix operator >>>: ForwardComposition

infix operator <|: BackwardApplication

infix operator |>: ForwardApplication
