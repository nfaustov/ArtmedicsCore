import Foundation

public final class Ledger: Codable {
    public var reports: [Report]

    public init(reports: [Report]) {
        self.reports = reports
    }

    public func reporting(_ reporting: Reporting, of type: PaymentType? = nil) -> Double {
        reports
            .map { $0.reporting(reporting, of: type) }
            .reduce(0.0, +)
    }

    public func incomeFraction(ofAccount type: PaymentType) -> Double {
        guard reporting(.income) > 0 else { return 0 }
        return reporting(.income, of: type) / reporting(.income)
    }
}

public enum Reporting: String, Hashable, Identifiable, CaseIterable {
    case profit = "Баланс"
    case income = "Доходы"
    case expense = "Расходы"

    public var id: Self {
        self
    }
}
