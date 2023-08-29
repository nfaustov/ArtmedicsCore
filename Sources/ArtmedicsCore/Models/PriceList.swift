import Foundation

public final class PriceList {
    public var categories: [Category]

    public var items: [PriceListItem] {
        categories.flatMap { $0.items }
    }

    public init(categories: [Category]) {
        self.categories = categories
    }

    public func filteredCategories(byItem filterText: String) -> [Category] {
        if filterText.isEmpty {
            return categories
        } else {
            return categories.filter { category in
                !category.items
                    .filter {
                        $0.title.localizedCaseInsensitiveContains(filterText) || $0.id.localizedCaseInsensitiveContains(filterText)
                    }
                    .isEmpty
            }
        }
    }
}

public extension PriceList {
    struct Category: Codable, Hashable, Identifiable {
        public let id: UUID
        public var title: String
        public var items: [PriceListItem]

        public init(id: UUID = UUID(), title: String, items: [PriceListItem] = []) {
            self.id = id
            self.title = title
            self.items = items
        }

        public func filteredItems(by filterText: String) -> [PriceListItem] {
            if filterText.isEmpty {
                return items
            } else {
                return items.filter {
                        $0.title.localizedCaseInsensitiveContains(filterText) || $0.id.localizedCaseInsensitiveContains(filterText)
                    }
            }
        }
    }
}

public struct PriceListItem: Codable, Hashable, Identifiable {
    public var id: String
    public var title: String
    public var price: Double
    public var costPrice: Double
    public var used: Int

    public init(id: String, title: String, price: Double, costPrice: Double = 0, used: Int = 0) {
        self.id = id
        self.title = title
        self.price = price
        self.costPrice = costPrice
        self.used = used
    }
}
