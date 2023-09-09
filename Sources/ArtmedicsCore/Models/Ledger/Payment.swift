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
        types.reduce(0.0) { $0 + $1.value }
    }
}
