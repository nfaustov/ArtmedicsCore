import Foundation

public struct Visit: Codable, Hashable, Identifiable {
    public let id: UUID
    public let registrationDate: Date
    public let visitDate: Date
    public var bill: Bill?

    public init(id: UUID = UUID(), registrationDate: Date, visitDate: Date, bill: Bill? = nil) {
        self.id = id
        self.registrationDate = registrationDate
        self.visitDate = visitDate
        self.bill = bill
    }
}

public struct Bill: Codable, Hashable, Identifiable {
    public let id: UUID
    public var services: [RenderedService]
    public var discount: Double
    public var contract: Data?

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
