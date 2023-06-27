import Foundation

public struct PatientAppointment: Codable, Hashable, Identifiable {
    public enum Status: String, Codable, CaseIterable, Identifiable {
        case none
        case registered = "Зарегистрирован"
        case confirmed = "Подтвержден"
        case came = "Пришел"
        case inProgress = "На приеме"
        case completed = "Завершен"
        case cancelled = "Отменен"

        public var id: Self {
            self
        }

        public static var allCases: [Status] {
            [.registered, .confirmed, .came, .inProgress]
        }
    }

    public let id: UUID
    public var scheduledTime: Date
    public var duration: TimeInterval
    public var patient: Patient?
    public var status: Status

    public init(id: UUID = UUID(), scheduledTime: Date, duration: TimeInterval, patient: Patient?, status: Status = .none) {
        self.id = id
        self.scheduledTime = scheduledTime
        self.duration = duration
        self.patient = patient
        self.status = status
    }
}
