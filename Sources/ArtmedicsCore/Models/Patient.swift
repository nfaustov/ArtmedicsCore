import Foundation

public struct Patient: Codable, Hashable {
    var id: UUID?
    var secondName: String
    var firstName: String
    var patronymicName: String
    var phoneNumber: String
    let passport: PassportData?
    let placeOfResidence: PlaceOfResidence?
    let treatmentPlan: TreatmentPlan?
    let visits: [Visit]

    init(
        id: UUID? = UUID(),
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

    var fullName: String {
        secondName + " " + firstName + " " + patronymicName
    }
}

public extension Patient {
    struct PassportData: Codable, Hashable {
        let secondName: String
        let name: String
        let patronymic: String
        let gender: String
        let seriesNumber: String
        let birtday: Date
        let birthPlace: String
        let issueDate: Date
        let authority: String
    }
}

public extension Patient {
    struct PlaceOfResidence: Codable, Hashable {
        let region: String
        let locality: String
        let streetAdress: String
        let house: String
        let appartment: String
    }
}

public struct TreatmentPlan: Codable, Hashable {
    enum Kind: String, Codable {
        case standard
        case pregnancy
    }

    let kind: Kind
    let startingDate: Date
    let expirationDate: Date
}

public struct Visit: Codable, Hashable {
    let registrationDate: Date
    let visitDate: Date
    let doctorsConclusion: DoctorsConclusion?
    let contract: Data?
}

public struct DoctorsConclusion: Codable, Hashable {
    let doctorName: String
    let service: Service
    let conclusion: Data?
}
