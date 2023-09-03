import Foundation

public extension Patient {
    struct DBModel: Person, Codable, Hashable, Identifiable {
        public let id: UUID
        public var secondName: String
        public var firstName: String
        public var patronymicName: String
        public var phoneNumber: String
        public var passport: PassportData?
        public var placeOfResidence: PlaceOfResidence?
        public var treatmentPlan: TreatmentPlan?

        init(
            id: UUID,
            secondName: String,
            firstName: String,
            patronymicName: String,
            phoneNumber: String,
            passport: PassportData? = nil,
            placeOfResidence: PlaceOfResidence? = nil,
            treatmentPlan: TreatmentPlan? = nil
        ) {
            self.id = id
            self.secondName = secondName
            self.firstName = firstName
            self.patronymicName = patronymicName
            self.phoneNumber = phoneNumber
            self.passport = passport
            self.placeOfResidence = placeOfResidence
            self.treatmentPlan = treatmentPlan
        }
    }
}
