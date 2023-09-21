import Foundation

public extension PatientAppointment {
    struct DBModel: Codable {
        public let id: UUID
        public let scheduledTime: Date
        public var duration: TimeInterval
        public var patientId: Patient.ID?
        public var status: Status

        init(id: UUID = UUID(), scheduledTime: Date, duration: TimeInterval, patientId: Patient.ID? = nil, status: Status) {
            self.id = id
            self.scheduledTime = scheduledTime
            self.duration = duration
            self.patientId = patientId
            self.status = status
        }
    }
}
