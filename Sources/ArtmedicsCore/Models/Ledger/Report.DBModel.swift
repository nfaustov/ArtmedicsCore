import Foundation

public extension Report {
    struct DBModel: Codable, Hashable, Identifiable {
        public let id: UUID
        public let date: Date
        public let startingCash: Double

        init(
            id: UUID,
            date: Date,
            startingCash: Double
        ) {
            self.id = id
            self.date = date
            self.startingCash = startingCash
        }
    }
}
