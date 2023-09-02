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

        switch payment.type {
        case .cash: cashBalance += payment.amount
        case .bank: bankBalance += payment.amount
        case .card: cardBalance += payment.amount
        }
    }

    public mutating func revoke(_ payment: Payment) {
        payments.removeAll(where: { $0.id == payment.id })

        switch payment.type {
        case .cash: cashBalance -= payment.amount
        case .bank: bankBalance -= payment.amount
        case .card: cardBalance -= payment.amount
        }
    }
}

public struct Payment: Codable, Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public let type: PaymentType
    public let amount: Double
    public let billID: UUID?
    public let createdAt: Date
    public let deletedAt: Date?

    public init(id: UUID = UUID(), title: String, type: PaymentType, amount: Double, billID: UUID? = nil, createdAt: Date = Date(), deletedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.type = type
        self.amount = amount
        self.billID = billID
        self.createdAt = createdAt
        self.deletedAt = deletedAt
    }
}

public extension Payment {
    enum PaymentType: String, Codable, Hashable, CaseIterable {
        case cash = "Наличные"
        case bank = "Терминал"
        case card = "Карта"
    }
}
