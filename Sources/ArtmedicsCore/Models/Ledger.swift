import Foundation

public struct Ledger: Codable, Hashable {
    public let date: Date
    public var balance: Double
    public var payments: [Payment] = []

    public mutating func payment(_ payment: Payment) {
        payments.append(payment)
        balance += payment.amount
    }
}

public struct Payment: Codable, Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public let amount: Double
}
