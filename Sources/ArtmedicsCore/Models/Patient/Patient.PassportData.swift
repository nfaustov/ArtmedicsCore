import Foundation

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

        public init(
            secondName: String,
            name: String,
            patronymic: String,
            gender: String,
            seriesNumber: String,
            birtday: Date,
            birthPlace: String,
            issueDate: Date,
            authority: String
        ) {
            self.secondName = secondName
            self.name = name
            self.patronymic = patronymic
            self.gender = gender
            self.seriesNumber = seriesNumber
            self.birtday = birtday
            self.birthPlace = birthPlace
            self.issueDate = issueDate
            self.authority = authority
        }
    }
}
