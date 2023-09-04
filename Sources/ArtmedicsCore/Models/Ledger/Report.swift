import Foundation

public struct Report: Codable, Hashable, Identifiable {
    public let id: UUID
    public let date: Date
    public var cashBalance: Double
    public var bankBalance: Double
    public var cardBalance: Double
    public var transactions: [Transaction] = []

    public var balance: Double {
        cashBalance + bankBalance + cardBalance
    }

    public init(id: UUID = UUID(), date: Date, cashBalance: Double, bankBalance: Double, cardBalance: Double, transactions: [Transaction]) {
        self.id = id
        self.date = date
        self.cashBalance = cashBalance
        self.bankBalance = bankBalance
        self.cardBalance = cardBalance
        self.transactions = transactions
    }

    public func fraction(ofAccount type: Transaction.Payment) -> Double {
        switch type {
        case .cash:
            return cashBalance / balance
        case .bank:
            return bankBalance / balance
        case .card:
            return cardBalance / balance
        }
    }

    public mutating func transaction(_ transaction: Transaction) {
        transactions.append(transaction)

        transaction.payments.forEach { payment in
            switch payment {
            case .cash(let amount): cashBalance += amount
            case .bank(let amount): bankBalance += amount
            case .card(let amount): cardBalance += amount
            }
        }
    }
}
