import Foundation

public struct Report: Codable, Hashable, Identifiable {
    public let id: UUID
    public let date: Date
    public let startingCash: Double
    public var payments: [Payment] = []

    public init(
        id: UUID = UUID(),
        date: Date,
        startingCash: Double,
        payments: [Payment]
    ) {
        self.id = id
        self.date = date
        self.startingCash = startingCash
        self.payments = payments
    }

    public init(from dbModel: Report.DBModel, payments: [Payment]) {
        self.id = dbModel.id
        self.date = dbModel.date
        self.startingCash = dbModel.startingCash
        self.payments = payments
    }

    public var dbModel: Report.DBModel {
        DBModel(
            id: id,
            date: date,
            startingCash: startingCash
        )
    }

    public var cashBalance: Double {
        startingCash + reporting(.profit, of: .cash()) + collected
    }

    public func reporting(_ reporting: Reporting, of type: PaymentType? = nil) -> Double {
        switch reporting {
        case .profit:
            return paymentTypes(ofType: type).reduce(0.0) { $0 + $1.value }
        case .income:
            return paymentTypes(ofType: type)
                .filter { $0.value > 0 }
                .reduce(0.0) { $0 + $1.value }
        case .expense:
            return paymentTypes(ofType: type)
                .filter { $0.value < 0 }
                .reduce(0.0) { $0 + $1.value}
        }
    }

    public func fraction(_ kind: Reporting, ofAccount type: PaymentType) -> Double {
        guard reporting(kind) != 0 else { return 0 }
        return reporting(kind, of: type) / reporting(kind)
    }
}

// MARK: - Private methods

private extension Report {
    private var collected: Double {
        payments
            .filter { $0.purpose == .collection }
            .flatMap { $0.types }
            .reduce(0.0) { $0 + $1.value }
    }

    func paymentTypes(ofType type: PaymentType?) -> [PaymentType] {
        let types = payments
            .filter { $0.purpose != .collection }
            .flatMap { $0.types }

        if let type { return types.filter { $0.isSameTypeAs(type) } }

        return types
    }
}
