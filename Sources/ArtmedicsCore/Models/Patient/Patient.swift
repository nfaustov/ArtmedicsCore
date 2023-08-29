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

    public init(from dbModel: Patient.DBModel, visits: [Visit]) {
        id = dbModel.id
        secondName = dbModel.secondName
        firstName = dbModel.firstName
        patronymicName = dbModel.patronymicName
        phoneNumber = dbModel.phoneNumber
        passport = dbModel.passport
        placeOfResidence = dbModel.placeOfResidence
        treatmentPlan = dbModel.treatmentPlan
        self.visits = visits
    }

    public var dbModel: Patient.DBModel {
        DBModel(
            id: id,
            secondName: secondName,
            firstName: firstName,
            patronymicName: patronymicName,
            phoneNumber: phoneNumber,
            passport: passport,
            placeOfResidence: placeOfResidence,
            treatmentPlan: treatmentPlan
        )
    }

    public var fullName: String {
        secondName + " " + firstName + " " + patronymicName
    }
}
