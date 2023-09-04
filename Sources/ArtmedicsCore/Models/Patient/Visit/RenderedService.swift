import Foundation

public struct RenderedService: Codable, Hashable, Identifiable {
    public let id: UUID
    public let pricelistItem: PriceList.Item
    public var performer: AnyEmployee
    public var agent: AnyEmployee?
    public var conclusion: Data?

    public init(
        id: UUID = UUID(),
        pricelistItem: PriceList.Item,
        performer: AnyEmployee,
        agent: AnyEmployee? = nil,
        conclusion: Data? = nil
    ) {
        self.id = id
        self.pricelistItem = pricelistItem
        self.performer = performer
        self.agent = agent
        self.conclusion = conclusion
    }
}
