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
        startingCash + reporting(.profit, of: .cash())
    }

    public func reporting(_ reporting: Reporting, of type: PaymentType? = nil) -> Double {
        switch reporting {
        case .profit:
            return  paymentTypes(ofType: type).reduce(0.0) { $0 + $1.value }
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

    public func incomeFraction(ofAccount type: PaymentType) -> Double {
        guard reporting(.income) > 0 else { return 0 }

        switch type {
        case .cash:
            return reporting(.income, of: .cash()) / reporting(.income)
        case .bank:
            return reporting(.income, of: .bank()) / reporting(.income)
        case .card:
            return reporting(.income, of: .card()) / reporting(.income)
        }
    }
}

// MARK: - Private methods

private extension Report {
    func paymentTypes(ofType type: PaymentType?) -> [PaymentType] {
        if let type {
            return payments
                .flatMap { $0.types }
                .filter { $0.isSameTypeAs(type) }
        } else {
            return payments.flatMap { $0.types }
        }
    }
}
