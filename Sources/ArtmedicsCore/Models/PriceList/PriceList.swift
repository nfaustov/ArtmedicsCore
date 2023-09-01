import Foundation

public final class PriceList {
    public var categories: [Category]

    public var items: [Item] {
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