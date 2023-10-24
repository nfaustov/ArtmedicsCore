import Foundation

public extension PriceList {
    struct Item: Codable, Hashable, Identifiable {
        public var id: String
        public var category: Department
        public var title: String
        public var price: Double
        public var costPrice: Double

        public init(id: String, category: Department, title: String, price: Double, costPrice: Double = 0) {
            self.id = id
            self.category = category
            self.title = title
            self.price = price
            self.costPrice = costPrice
        }
    }
}
