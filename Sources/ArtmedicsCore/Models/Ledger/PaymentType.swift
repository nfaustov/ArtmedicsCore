import Foundation

public enum PaymentType: Codable, Hashable, CaseIterable {
    case cash(_ amount: Double = 0)
    case bank(_ amount: Double = 0)
    case card(_ amount: Double = 0)

    public var title: String {
        switch self {
        case .cash: return "Наличные"
        case .bank: return "Терминал"
        case .card: return "Карта"
        }
    }

    public var value: Double {
        get {
            switch self {
            case .cash(let amount): return amount
            case .bank(let amount): return amount
            case .card(let amount): return amount
            }
        }
        set {
            switch self {
            case .cash: self = .cash(newValue)
            case .bank: self = .bank(newValue)
            case .card: self = .card(newValue)
            }
        }
    }

    public static var allCases: [PaymentType] {
        [.cash(), .bank(), .card()]
    }
}
