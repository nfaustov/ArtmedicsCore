import Foundation

public struct Patient: Codable, Hashable, Identifiable {
    public let id: UUID
    public var secondName: String
    public var firstName: String
    public var patronymicName: String
    public var phoneNumber: String
    public var passport: PassportData?
    public var placeOfResidence: PlaceOfResidence?
    public var treatmentPlan: TreatmentPlan?
    public var visits: [Visit]

    public init(
        id: UUID = UUID(),
        secondName: String,
        firstName: String,
        patronymicName: String,
        phoneNumber: String,
        passport: PassportData? = nil,
        placeOfResidence: PlaceOfResidence? = nil,
        treatmentPlan: TreatmentPlan? = nil,
        visits: [Visit] = []
    ) {
        self.id = id
        self.secondName = secondName
        self.firstName = firstName
        self.patronymicName = patronymicName
        self.phoneNumber = phoneNumber
        self.passport = passport
        self.placeOfResidence = placeOfResidence
        self.treatmentPlan = treatmentPlan
        self.visits = visits
    }

    public var fullName: String {
        secondName + " " + firstName + " " + patronymicName
    }
}

public extension Patient {
    struct PassportData: Codable, Hashable {
        public let secondName: String
        public let name: String
        public let patronymic: String
        public let gender: String
        public let seriesNumber: String
        public let birtday: Date
        public let birthPlace: String
        public let issueDate: Date
        public let authority: String
    }
}

public extension Patient {
    struct PlaceOfResidence: Codable, Hashable {
        public let region: String
        public let locality: String
        public let streetAdress: String
        public let house: String
        public let appartment: String
    }
}

public struct TreatmentPlan: Codable, Hashable {
    public enum Kind: String, Codable {
        case standard
        case pregnancy
        case none
    }

    public let kind: Kind
    public let startingDate: Date
    public let expirationDate: Date
}

public struct Visit: Codable, Hashable {
    public let registrationDate: Date
    public let visitDate: Date
    public let check: Check
    public let conclusions: [DoctorsConclusion]
    public let contract: Data?
}

public struct Check: Codable, Hashable {
    public let services: [Service]
    public let discount: Double

    public var totalPrice: Double {
        let price = services
            .map { $0.price }
            .reduce(0.0, +)

        return price - discount
    }
}

public struct DoctorsConclusion: Codable, Hashable {
    public let doctorName: String
    public let service: Service
    public let conclusion: Data?
}
