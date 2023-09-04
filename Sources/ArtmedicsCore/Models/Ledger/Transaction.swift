import Foundation

public struct Transaction: Codable, Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public let payments: [Payment]
    public var bill: Bill?
    public let createdAt: Date
    public let deletedAt: Date?

    public init(
        id: UUID = UUID(),
        title: String,
        payments: [Payment],
        bill: Bill? = nil,
        createdAt: Date = Date(),
        deletedAt: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.payments = payments
        self.bill = bill
        self.createdAt = createdAt
        self.deletedAt = deletedAt
    }
}

public extension Transaction {
    enum Payment: Codable, Hashable, CaseIterable {
        case cash(amount: Double = 0)
        case bank(amount: Double = 0)
        case card(amount: Double = 0)

        var title: String {
            switch self {
            case .cash: return "Наличные"
            case .bank: return "Терминал"
            case .card: return "Карта"
            }
        }

        public static var allCases: [Transaction.Payment] {
            [.cash(), .bank(), .card()]
        }
    }
}
