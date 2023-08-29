import Foundation

public extension PriceList {
    struct Category: Codable, Hashable, Identifiable {
        public let id: UUID
        public var title: String
        public var items: [Item]

        public init(id: UUID = UUID(), title: String, items: [Item] = []) {
            self.id = id
            self.title = title
            self.items = items
        }

        public init(from dbModel: Category.DBModel, items: [Item]) {
            self.id = dbModel.id
            self.title = dbModel.title
            self.items = items
        }

        public var dbModel: Category.DBModel {
            DBModel(id: id, title: title)
        }

        public func filteredItems(by filterText: String) -> [Item] {
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


public extension PriceList.Category {
    struct DBModel: Codable {
        public let id: UUID
        public let title: String

        init(id: UUID, title: String) {
            self.id = id
            self.title = title
        }
    }
}
