import Foundation

public struct Visit: Codable, Hashable, Identifiable {
    public let id: UUID
    public let registrationDate: Date
    public let visitDate: Date
    public let check: Check?

    public init(id: UUID = UUID(), registrationDate: Date, visitDate: Date, check: Check? = nil) {
        self.id = id
        self.registrationDate = registrationDate
        self.visitDate = visitDate
        self.check = check
    }
}

public struct Check: Codable, Hashable, Identifiable {
    public let id: UUID
    public let services: [RenderedService]
    public let discount: Double
    public let contract: Data?

    public var price: Double {
        services
            .map { $0.priceListItem.price }
            .reduce(0.0, +)
    }

    public var totalPrice: Double {
        price - discount
    }

    public init(id: UUID = UUID(), services: [RenderedService], discount: Double = 0, contract: Data? = nil) {
        self.id = id
        self.services = services
        self.discount = discount
        self.contract = contract
    }
}

public struct RenderedService: Codable, Hashable, Identifiable {
    public let id: UUID
    public let priceListItem: PriceList.Item
    public let performer: Doctor
    public let agent: Doctor?
    public let conclusion: Data?

    public init(id: UUID = UUID(), priceListItem: PriceList.Item, performer: Doctor, agent: Doctor? = nil, conclusion: Data? = nil) {
        self.id = id
        self.priceListItem = priceListItem
        self.performer = performer
        self.agent = agent
        self.conclusion = conclusion
    }
}
