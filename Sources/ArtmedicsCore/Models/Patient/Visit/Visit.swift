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
