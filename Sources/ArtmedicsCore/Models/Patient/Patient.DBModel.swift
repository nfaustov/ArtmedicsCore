import Foundation

public extension Patient {
    struct DBModel: Codable, Hashable, Identifiable {
        public let id: UUID
        public let secondName: String
        public let firstName: String
        public let patronymicName: String
        public let phoneNumber: String
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
