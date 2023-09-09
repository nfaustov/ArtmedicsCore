import Foundation

public final class Ledger: Codable {
    public var reports: [Report]
    public var paymentPurposes: [String]
    public var paymentSources: [String]

    public init(reports: [Report], paymentPurposes: [String], paymentSources: [String]) {
        self.reports = reports
        self.paymentPurposes = paymentPurposes
        self.paymentSources = paymentSources
    }

    public func income(_ type: PaymentType? = nil) -> Double {
        if let type {
            switch type {
            case .cash:
                return reports.map { $0.cashIncome }.reduce(0.0, +)
            case .bank:
                return  reports.map { $0.bankIncome }.reduce(0.0, +)
            case .card:
                return reports.map { $0.cardIncome }.reduce(0.0, +)
            }
        } else {
            return reports
                .map { $0.income }
                .reduce(0.0, +)
        }
    }

    public func fraction(ofAccount type: PaymentType) -> Double {
        income(type) / income()
    }
}
