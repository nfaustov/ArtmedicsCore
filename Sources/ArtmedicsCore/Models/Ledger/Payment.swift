import Foundation

public struct Payment: Codable, Hashable, Identifiable {
    public let id: UUID
    public let date: Date
    public let purpose: Payment.Purpose
    public let methods: [Payment.Method]
    public var bill: Bill?

    public init(
        id: UUID = UUID(),
        date: Date = .now,
        purpose: Payment.Purpose,
        methods: [Payment.Method],
        bill: Bill? = nil
    ) {
        self.id = id
        self.date = date
        self.purpose = purpose
        self.methods = methods
        self.bill = bill
    }

    public var totalAmount: Double {
        methods.reduce(0.0) { $0 + $1.value }
    }
}
