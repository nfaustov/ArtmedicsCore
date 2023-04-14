import Foundation

public struct Ledger: Codable, Hashable, Identifiable {
    public let id: UUID
    public let date: Date
    public var cashBalance: Double
    public var bankBalance: Double
    public var cardBalance: Double
    public var payments: [Payment] = []

    public var balance: Double {
        cashBalance + bankBalance + cardBalance
    }

    public mutating func payment(_ payment: Payment) {
        payments.append(payment)

        switch payment.type {
        case .cash: cashBalance += payment.amount
        case .bank: bankBalance += payment.amount
        case .card: cardBalance += payment.amount
        }
    }
}

public struct Payment: Codable, Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public let type: PaymentType
    public let amount: Double
}

public extension Payment {
    enum PaymentType: Codable, Hashable {
        case cash
        case bank
        case card
    }
}
