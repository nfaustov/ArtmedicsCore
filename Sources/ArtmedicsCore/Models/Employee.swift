import Foundation

public protocol Employee: Person {
    var salaryType: SalaryType { get set }
}

public struct AnyEmployee: Employee, Codable, Hashable, Identifiable {
    public let id: UUID
    public var secondName: String
    public var firstName: String
    public var patronymicName: String
    public var phoneNumber: String
    public var salaryType: SalaryType
}

public enum SalaryType: Codable, Hashable {
    case pieceRate(rate: Double)
    case monthly(amount: Int)
    case hourly(amount: Int)

    var title: String {
        switch self {
        case .pieceRate:
            return "Сдельная"
        case .monthly:
            return "Ежемесячная"
        case .hourly:
            return "Почасовая"
        }
    }
}
