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

    public init(
        id: UUID = UUID(),
        date: Date,
        cashBalance: Double,
        bankBalance: Double,
        cardBalance: Double,
        payments: [Payment]
    ) {
        self.id = id
        self.date = date
        self.cashBalance = cashBalance
        self.bankBalance = bankBalance
        self.cardBalance = cardBalance
        self.payments = payments
    }

    public init(from dbModel: Report.DBModel, payments: [Payment]) {
        self.id = dbModel.id
        self.date = dbModel.date
        self.cashBalance = dbModel.cashBalance
        self.bankBalance = dbModel.bankBalance
        self.cardBalance = dbModel.cardBalance
        self.payments = payments
    }

    public var dbModel: Report.DBModel {
        DBModel(
            id: id,
            date: date,
            cashBalance: cashBalance,
            bankBalance: bankBalance,
            cardBalance: cardBalance
        )
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
}
