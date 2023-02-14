import Foundation

public struct PatientAppointment: Codable, Hashable {
    let id: UUID?
    var scheduledTime: Date
    var duration: TimeInterval
    var patient: Patient?

    init(id: UUID? = UUID(), scheduledTime: Date, duration: TimeInterval, patient: Patient?) {
        self.id = id
        self.scheduledTime = scheduledTime
        self.duration = duration
        self.patient = patient
    }
}
