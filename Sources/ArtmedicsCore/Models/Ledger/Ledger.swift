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

    public func balance(_ type: Payment.PaymentType? = nil) -> Double {
        if let type {
            var value = [Double]()

            switch type {
            case .cash:
                value = reports.map { $0.cashBalance }
            case .bank:
                value = reports.map { $0.bankBalance }
            case .card:
                value = reports.map { $0.cardBalance }
            }
            return value.reduce(0, +)
        } else {
            return reports
                .map { $0.balance }
                .reduce(0, +)
        }
    }

    public func fraction(ofAccount type: Payment.PaymentType) -> Double {
        balance(type) / balance()
    }
}
