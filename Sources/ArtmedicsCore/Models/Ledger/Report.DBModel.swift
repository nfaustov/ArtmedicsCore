import Foundation

public extension Report {
    struct DBModel: Codable, Hashable, Identifiable {
        public let id: UUID
        public let date: Date
        public let startingCash: Double
        public var cashIncome: Double
        public var bankIncome: Double
        public var cardIncome: Double

        init(
            id: UUID,
            date: Date,
            startingCash: Double,
            cashIncome: Double,
            bankIncome: Double,
            cardIncome: Double
        ) {
            self.id = id
            self.date = date
            self.startingCash = startingCash
            self.cashIncome = cashIncome
            self.bankIncome = bankIncome
            self.cardIncome = cardIncome
        }
    }
}
