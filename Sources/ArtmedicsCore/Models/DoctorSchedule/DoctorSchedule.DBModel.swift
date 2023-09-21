import Foundation

public extension DoctorSchedule {
    struct DBModel: Codable, Hashable, Identifiable {
        public let id: UUID
        public let doctorId: Doctor.ID
        public var cabinet: Int
        public var starting: Date
        public var ending: Date

        init(id: UUID, doctorId: Doctor.ID, cabinet: Int, starting: Date, ending: Date) {
            self.id = id
            self.doctorId = doctorId
            self.cabinet = cabinet
            self.starting = starting
            self.ending = ending
        }
    }
}
