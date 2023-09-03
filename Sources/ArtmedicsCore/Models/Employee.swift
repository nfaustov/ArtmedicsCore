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

    public var title: String {
        switch self {
        case .pieceRate:
            return "Сдельная"
        case .monthly:
            return "Ежемесячная"
        case .hourly:
            return "Почасовая"
        }
    }

    public static var allCasesTitles: [String] {
        ["Сдельная", "Ежемесячная", "Почасовая"]
    }

    public init?(title: String, rate: Double) {
        switch title {
        case "Сдельная":
            self = .pieceRate(rate: rate)
        default:
            return nil
        }
    }

    public init?(title: String, amount: Int) {
        switch title {
        case "Ежемесячная":
            self = .monthly(amount: amount)
        case "Почасовая":
            self = .hourly(amount: amount)
        default:
            return nil
        }
    }
}
