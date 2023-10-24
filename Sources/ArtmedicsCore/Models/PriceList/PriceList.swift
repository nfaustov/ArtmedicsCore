import Foundation

public final class PriceList {
    public var items: [PriceList.Item]
    public var billTemplates: [BillTemplate]

    public init(items: [PriceList.Item], billTemplates: [BillTemplate] = []) {
        self.items = items
        self.billTemplates = billTemplates
    }

    public func filteredItems(by filterText: String, for category: Department) -> [Item] {
        if filterText.isEmpty {
            return items.filter { $0.category == category }
        } else {
            return items
                .filter { $0.category == category }
                .filter {
                    $0.title.localizedCaseInsensitiveContains(filterText) || 
                    $0.id.localizedCaseInsensitiveContains(filterText)
                }
        }
    }

    public func filteredCategories(byItem filterText: String) -> [Department] {
        if filterText.isEmpty {
            return Department.allCases
        } else {
            return Department.allCases.filter { !filteredItems(by: filterText, for: $0).isEmpty }
        }
    }
}
