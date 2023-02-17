import Foundation

public final class PriceList {
    public let categories: [ServicesCategory]

    public init(categories: [ServicesCategory]) {
        self.categories = categories
    }
}

public struct ServicesCategory: Codable, Hashable {
    public let tittle: String
    public let subCategories: [ServicesCategory]?
    public let services: [Service]?
}

public struct Service: Codable, Hashable {
    public let code: String
    public let title: String
    public let price: Double
    public let costPrice: Double
}
