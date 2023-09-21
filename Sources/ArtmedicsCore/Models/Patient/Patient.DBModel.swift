import Foundation

public extension Patient {
    struct DBModel: Person, Codable, Hashable, Identifiable {
        public let id: UUID
        public var secondName: String
        public var firstName: String
        public var patronymicName: String
        public var phoneNumber: String
        public var balance: Double
        public var passport: PassportData?
        public var placeOfResidence: PlaceOfResidence?
        public var treatmentPlan: TreatmentPlan?
        public var createdAt: Date

        init(
            id: UUID,
            secondName: String,
            firstName: String,
            patronymicName: String,
            phoneNumber: String,
            balance: Double = 0,
            passport: PassportData? = nil,
            placeOfResidence: PlaceOfResidence? = nil,
            treatmentPlan: TreatmentPlan? = nil,
            createdAt: Date
        ) {
            self.id = id
            self.secondName = secondName
            self.firstName = firstName
            self.patronymicName = patronymicName
            self.phoneNumber = phoneNumber
            self.balance = balance
            self.passport = passport
            self.placeOfResidence = placeOfResidence
            self.treatmentPlan = treatmentPlan
            self.createdAt = createdAt
        }
    }
}
