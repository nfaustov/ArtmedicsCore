import Foundation

public struct PatientAppointment: Codable, Hashable {
    public let id: UUID
    public var scheduledTime: Date
    public var duration: TimeInterval
    public var patient: Patient?

    public init(id: UUID = UUID(), scheduledTime: Date, duration: TimeInterval, patient: Patient?) {
        self.id = id
        self.scheduledTime = scheduledTime
        self.duration = duration
        self.patient = patient
    }
}
