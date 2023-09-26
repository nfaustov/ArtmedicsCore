import Foundation

public final class PriceList {
    public var categories: [Category]
    public var billTemplates: [BillTemplate]

    public var items: [Item] {
        categories.flatMap { $0.items }
    }

    public init(categories: [Category], billTemplates: [BillTemplate] = []) {
        self.categories = categories
        self.billTemplates = billTemplates
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

    public func categoryForItem(_ pricelistItem: PriceList.Item) -> Category {
        if let category = categories.first(where: { $0.items.contains(where: { $0.id == pricelistItem.id }) }) {
            return category
        } else {
            return Category(title: "Другие")
        }
    }
}

public struct BillTemplate: Codable, Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public var services: [RenderedService]

    public init(id: UUID = UUID(), title: String, services: [RenderedService] = []) {
        self.id = id
        self.title = title
        self.services = services
    }
}
