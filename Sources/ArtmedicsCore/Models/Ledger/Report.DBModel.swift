import Foundation

public extension Report {
    struct DBModel: Codable, Hashable, Identifiable {
        public let id: UUID
        public let date: Date
        public let startingCash: Double
        public let collected: Double

        init(
            id: UUID,
            date: Date,
            startingCash: Double,
            collected: Double
        ) {
            self.id = id
            self.date = date
            self.startingCash = startingCash
            self.collected = collected
        }
    }
}
