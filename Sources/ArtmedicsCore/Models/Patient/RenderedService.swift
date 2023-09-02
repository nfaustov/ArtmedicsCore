import Foundation

public struct RenderedService: Codable, Hashable, Identifiable {
    public let id: UUID
    public let categoryTitle: String
    public let pricelistItem: PriceList.Item
    public var performer: Doctor
    public var agent: Doctor?
    public var conclusion: Data?

    public init(
        id: UUID = UUID(),
        categoryTitle: String,
        pricelistItem: PriceList.Item,
        performer: Doctor,
        agent: Doctor? = nil,
        conclusion: Data? = nil
    ) {
        self.id = id
        self.categoryTitle = categoryTitle
        self.pricelistItem = pricelistItem
        self.performer = performer
        self.agent = agent
        self.conclusion = conclusion
    }

    public init(from dbModel: RenderedService.DBModel, performer: Doctor, agent: Doctor?) {
        self.id = dbModel.id
        self.categoryTitle = dbModel.categoryTitle
        self.pricelistItem = dbModel.pricelistItem
        self.performer = performer
        self.agent = agent
        self.conclusion = dbModel.conclusion
    }

    public var dbModel: RenderedService.DBModel {
        DBModel(
            id: id,
            categoryTitle: categoryTitle,
            pricelistItem: pricelistItem,
            performerId: performer.id,
            agentId: agent?.id,
            conclusion: conclusion
        )
    }
}

public extension RenderedService {
    struct DBModel: Codable {
        public let id: UUID
        public let categoryTitle: String
        public let pricelistItem: PriceList.Item
        public var performerId: UUID
        public var agentId: UUID?
        public var conclusion: Data?

        init(
            id: UUID,
            categoryTitle: String,
            pricelistItem: PriceList.Item,
            performerId: UUID,
            agentId: UUID? = nil,
            conclusion: Data? = nil
        ) {
            self.id = id
            self.categoryTitle = categoryTitle
            self.pricelistItem = pricelistItem
            self.performerId = performerId
            self.agentId = agentId
            self.conclusion = conclusion
        }
    }
}
