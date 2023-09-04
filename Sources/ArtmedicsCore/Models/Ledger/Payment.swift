import Foundation

public struct Payment: Codable, Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public let types: [PaymentType]
    public var bill: Bill?
    public let createdAt: Date
    public let deletedAt: Date?

    public init(
        id: UUID = UUID(),
        title: String,
        types: [PaymentType],
        bill: Bill? = nil,
        createdAt: Date = Date(),
        deletedAt: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.types = types
        self.bill = bill
        self.createdAt = createdAt
        self.deletedAt = deletedAt
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

        public static var allCases: [Payment.PaymentType] {
            [.cash(), .bank(), .card()]
        }
    }
}
