import Foundation

public struct Report: Codable, Hashable, Identifiable {
    public let id: UUID
    public let date: Date
    public let startingCash: Double
    public var cashIncome: Double
    public var bankIncome: Double
    public var cardIncome: Double
    public var payments: [Payment] = []

    public var income: Double {
        cashIncome + bankIncome + cardIncome
    }

    public init(
        id: UUID = UUID(),
        date: Date,
        startingCash: Double,
        cashIncome: Double,
        bankIncome: Double,
        cardIncome: Double,
        payments: [Payment]
    ) {
        self.id = id
        self.date = date
        self.startingCash = startingCash
        self.cashIncome = cashIncome
        self.bankIncome = bankIncome
        self.cardIncome = cardIncome
        self.payments = payments
    }

    public init(from dbModel: Report.DBModel, payments: [Payment]) {
        self.id = dbModel.id
        self.date = dbModel.date
        self.startingCash = dbModel.startingCash
        self.cashIncome = dbModel.cashIncome
        self.bankIncome = dbModel.bankIncome
        self.cardIncome = dbModel.cardIncome
        self.payments = payments
    }

    public var dbModel: Report.DBModel {
        DBModel(
            id: id,
            date: date,
            startingCash: startingCash,
            cashIncome: cashIncome,
            bankIncome: bankIncome,
            cardIncome: cardIncome
        )
    }

    public var cashBalance: Double {
        startingCash + cashIncome
    }

    public func fraction(ofAccount type: PaymentType) -> Double {
        switch type {
        case .cash:
            return cashIncome / income
        case .bank:
            return bankIncome / income
        case .card:
            return cardIncome / income
        }
    }
}
