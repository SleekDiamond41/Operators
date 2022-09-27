import Foundation

infix operator <>: SingleTypeComposition

infix operator >=>: EffectfulComposition

infix operator <<<: BackwardComposition

infix operator >>>: ForwardComposition

infix operator <>>: FromInoutComposition

infix operator ><>: ToInoutComposition

infix operator |>>: MutatingForwadApplication

infix operator <|: BackwardApplication

infix operator |>: ForwardApplication

