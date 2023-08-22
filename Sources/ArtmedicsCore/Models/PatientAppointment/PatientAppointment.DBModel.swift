import Foundation

public extension PatientAppointment {
    struct DBModel: Codable, Equatable, Hashable, Identifiable {
        public let id: UUID
        public let scheduledTime: Date
        public var duration: TimeInterval
        public var patientId: UUID?
        public var status: Status

        init(id: UUID = UUID(), scheduledTime: Date, duration: TimeInterval, patientId: UUID? = nil, status: Status) {
            self.id = id
            self.scheduledTime = scheduledTime
            self.duration = duration
            self.patientId = patientId
            self.status = status
        }
    }
}
