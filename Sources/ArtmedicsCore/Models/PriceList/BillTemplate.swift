import Foundation

public struct BillTemplate: Codable, Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public var services: [RenderedService]

    public init(id: UUID = UUID(), title: String, services: [RenderedService] = []) {
        self.id = id
        self.title = title
        self.services = services
    }
}
