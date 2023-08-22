import Foundation

public extension DoctorSchedule {
    struct DBModel: Codable, Equatable, Hashable, Identifiable {
        public let id: UUID
        public let doctor: Doctor
        public var cabinet: Int
        public var starting: Date
        public var ending: Date

        init(id: UUID = UUID(), doctor: Doctor, cabinet: Int, starting: Date, ending: Date) {
            self.id = id
            self.doctor = doctor
            self.cabinet = cabinet
            self.starting = starting
            self.ending = ending
        }
    }
}
