import Foundation

public extension Patient {
    struct PassportData: Codable, Hashable {
        public let gender: Gender
        public let seriesNumber: String
        public let birthday: Date
        public let issueDate: Date
        public let authority: String

        public init(
            gender: Gender,
            seriesNumber: String,
            birthday: Date,
            issueDate: Date,
            authority: String
        ) {
            self.gender = gender
            self.seriesNumber = seriesNumber
            self.birthday = birthday
            self.issueDate = issueDate
            self.authority = authority
        }
    }

    enum Gender: String, Codable, Hashable, CaseIterable {
        case male = "муж"
        case female = "жен"
        case unknown = "-"
    }
}
