import Foundation

public struct Payment: Codable, Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public let types: [PaymentType]
    public var bill: Bill?
    public let createdAt: Date

    public init(
        id: UUID = UUID(),
        title: String,
        types: [PaymentType],
        bill: Bill? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.types = types
        self.bill = bill
        self.createdAt = createdAt
    }

    public var totalAmount: Double {
        var value = 0.0

        types.forEach { type in
            switch type {
            case .cash(let amount): value += amount
            case .bank(let amount): value += amount
            case .card(let amount): value += amount
            }
        }

        return value
    }
}

public extension Payment {
    enum PaymentType: Codable, Hashable, CaseIterable {
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
                case .cash: self = .card(newValue)
                case .bank: self = .bank(newValue)
                case .card: self = .card(newValue)
                }
            }
        }

        public static var allCases: [Payment.PaymentType] {
            [.cash(), .bank(), .card()]
        }
    }
}
