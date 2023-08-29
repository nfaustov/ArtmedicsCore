import Foundation

public struct Category: Codable, Hashable, Identifiable {
    public let id: UUID
    public var title: String
    public var items: [PriceListItem]

    public init(id: UUID = UUID(), title: String, items: [PriceListItem] = []) {
        self.id = id
        self.title = title
        self.items = items
    }

    public init(from dbModel: Category.DBModel, items: [PriceListItem]) {
        self.id = dbModel.id
        self.title = dbModel.title
        self.items = items
    }

    public var dbModel: Category.DBModel {
        DBModel(id: id, title: title)
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

public extension Category {
    struct DBModel: Codable {
        public let id: UUID
        public let title: String

        init(id: UUID, title: String) {
            self.id = id
            self.title = title
        }
    }
}
