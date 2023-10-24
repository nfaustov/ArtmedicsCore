import Foundation

public final class PriceList {
    public var items: [PriceList.Item]
    public var billTemplates: [BillTemplate]

    public init(items: [PriceList.Item], billTemplates: [BillTemplate] = []) {
        self.items = items
        self.billTemplates = billTemplates
    }

    public func filteredItems(by filterText: String) -> [Item] {
        if filterText.isEmpty {
            return items
        } else {
            return items
                .filter {
                    $0.title.localizedCaseInsensitiveContains(filterText) || 
                    $0.id.localizedCaseInsensitiveContains(filterText)
                }
                .sorted(by: { $0.category.rawValue < $1.category.rawValue })
        }
    }
}
