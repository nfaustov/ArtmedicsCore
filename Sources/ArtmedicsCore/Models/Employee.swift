import Foundation

public protocol Employee: Person {
    var salary: Salary { get set }
    var agentFee: Double { get set }
}

public struct AnyEmployee: Employee, Codable, Hashable, Identifiable {
    public let id: UUID
    public var secondName: String
    public var firstName: String
    public var patronymicName: String
    public var phoneNumber: String
    public var balance: Double
    public var salary: Salary
    public var agentFee: Double
}

public enum Salary: Codable, Hashable, CaseIterable {
    case pieceRate(rate: Double = 0.4)
    case perService(amount: Int = 0)
    case monthly(amount: Int = 0)
    case hourly(amount: Int = 0)

    public var title: String {
        switch self {
        case .pieceRate: return "Сдельная"
        case .perService: return "За прием"
        case .monthly: return "Ежемесячная"
        case .hourly: return "Почасовая"
        }
    }

    public static var allCases: [Salary] {
        [.pieceRate(), .perService(), .monthly(), .hourly()]
    }
}
