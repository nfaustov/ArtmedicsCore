import Foundation

public struct Visit: Codable, Hashable, Identifiable {
    public let id: UUID
    public let registrationDate: Date
    public let visitDate: Date
    public var cancellationDate: Date?
    public var bill: Bill?

    public init(
        id: UUID = UUID(),
        registrationDate: Date,
        visitDate: Date,
        cancellationDate: Date? = nil,
        bill: Bill? = nil
    ) {
        self.id = id
        self.registrationDate = registrationDate
        self.visitDate = visitDate
        self.cancellationDate = cancellationDate
        self.bill = bill
    }
}
