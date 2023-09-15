import Foundation

public struct Visit: Codable, Hashable, Identifiable {
    public let id: UUID
    public let registrationDate: Date
    public let visitDate: Date
    public var cancellationDate: Date?
    public var isRefund: Bool
    public var bill: Bill?

    public init(
        id: UUID = UUID(),
        registrationDate: Date,
        visitDate: Date,
        cancellationDate: Date? = nil,
        isRefund: Bool = false,
        bill: Bill? = nil
    ) {
        self.id = id
        self.registrationDate = registrationDate
        self.visitDate = visitDate
        self.cancellationDate = cancellationDate
        self.isRefund = isRefund
        self.bill = bill
    }
}
