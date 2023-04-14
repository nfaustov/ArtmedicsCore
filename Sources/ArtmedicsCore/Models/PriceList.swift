import Foundation

public final class PriceList {
    public let categories: [Category]

    public init(categories: [Category]) {
        self.categories = categories
    }
}

public extension PriceList {
    struct Category: Codable, Hashable, Identifiable {
        public let id: UUID
        public let title: String
        public let subCategories: [Category]?
        public let items: [PriceListItem]?
    }
}

public struct PriceListItem: Codable, Hashable, Identifiable {
    public let id: String
    public let title: String
    public let price: Double
    public let costPrice: Double
}
