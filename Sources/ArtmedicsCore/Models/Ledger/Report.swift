import Foundation

public struct Report: Codable, Hashable, Identifiable {
    public let id: UUID
    public let date: Date
    public var cashBalance: Double
    public var bankBalance: Double
    public var cardBalance: Double
    public var payments: [Payment] = []

    public var balance: Double {
        cashBalance + bankBalance + cardBalance
    }

    public init(id: UUID = UUID(), date: Date, cashBalance: Double, bankBalance: Double, cardBalance: Double, payments: [Payment]) {
        self.id = id
        self.date = date
        self.cashBalance = cashBalance
        self.bankBalance = bankBalance
        self.cardBalance = cardBalance
        self.payments = payments
    }

    public func fraction(ofAccount type: Payment.PaymentType) -> Double {
        switch type {
        case .cash:
            return cashBalance / balance
        case .bank:
            return bankBalance / balance
        case .card:
            return cardBalance / balance
        }
    }

    public mutating func payment(_ payment: Payment) {
        payments.append(payment)

        payment.types.forEach { type in
            switch type {
            case .cash(let amount): cashBalance += amount
            case .bank(let amount): bankBalance += amount
            case .card(let amount): cardBalance += amount
            }
        }
    }
}
