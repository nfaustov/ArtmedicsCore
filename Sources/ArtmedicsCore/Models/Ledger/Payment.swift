import Foundation

public struct Payment: Codable, Hashable, Identifiable {
    public let id: UUID
    public let date: Date
    public let purpose: Purpose
    public let types: [PaymentType]
    public var bill: Bill?

    public init(
        id: UUID = UUID(),
        date: Date = .now,
        purpose: Purpose,
        types: [PaymentType],
        bill: Bill? = nil
    ) {
        self.id = id
        self.date = date
        self.purpose = purpose
        self.types = types
        self.bill = bill
    }

    public var totalAmount: Double {
        types.reduce(0.0) { $0 + $1.value }
    }
}
