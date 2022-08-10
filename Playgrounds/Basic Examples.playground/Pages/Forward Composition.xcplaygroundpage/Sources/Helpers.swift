import Foundation


public struct Person: Codable {
    public var age: Int
    
    public init(age: Int) {
        self.age = age
    }
}

public func message(for ageGroup: AgeGroup) -> String {
    switch ageGroup {
    case .young:
        return "You'll get there one day"
    case .midAge:
        return "Enjoy it while you can"
    case .oldGeezer:
        return "It might be time for a prostate exam"
    }
}

public enum AgeGroup {
    case young
    case midAge
    case oldGeezer
    
    public var message: String {
        Forward_Composition_PageSources.message(for: self)
    }
    
    public init(_ age: Int) {
        switch age {
        case 0..<12:
            self = .young
        case 12..<50:
            self = .midAge
        default:
            self = .oldGeezer
        }
    }
}

public func getPeople() -> [Person] {
    [
        Person(age: 37),
        Person(age: 25),
        Person(age: 53),
    ]
}
