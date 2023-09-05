import Foundation

public extension Report {
    struct DBModel: Codable, Hashable, Identifiable {
        public let id: UUID
        public let date: Date
        public var cashBalance: Double
        public var bankBalance: Double
        public var cardBalance: Double

        init(
            id: UUID,
            date: Date,
            cashBalance: Double,
            bankBalance: Double,
            cardBalance: Double
        ) {
            self.id = id
            self.date = date
            self.cashBalance = cashBalance
            self.bankBalance = bankBalance
            self.cardBalance = cardBalance
        }
    }
}
