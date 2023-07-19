import Foundation

public final class PriceList {
    public var categories: [Category]

    public init(categories: [Category]) {
        self.categories = categories
    }
}

public extension PriceList {
    struct Category: Codable, Hashable, Identifiable {
        public let id: UUID
        public var title: String
        public var subCategories: [Category]?
        public var items: [PriceListItem]?
    }
}

public struct PriceListItem: Codable, Hashable, Identifiable {
    public var id: String
    public var title: String
    public var price: Double
    public var costPrice: Double = 0
    public var used: Int = 0
}
