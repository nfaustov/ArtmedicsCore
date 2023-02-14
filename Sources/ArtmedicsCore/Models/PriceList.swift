import Foundation

public final class PriceList {
    let categories: [ServicesCategory]

    init(categories: [ServicesCategory]) {
        self.categories = categories
    }
}

public struct ServicesCategory: Codable, Hashable {
    let tittle: String
    let subCategories: [ServicesCategory]?
    let services: [Service]?
}

public struct Service: Codable, Hashable {
    let code: String
    let title: String
    let price: Double
    let costPrice: Double
}
