import Foundation

public struct PatientAppointment: Codable, Hashable, Identifiable {
    public let id: UUID
    public let scheduledTime: Date
    public var duration: TimeInterval
    public var patient: Patient?
    public var status: Status

    public var endTime: Date {
        scheduledTime.addingTimeInterval(duration)
    }

    public init(
        id: UUID = UUID(),
        scheduledTime: Date,
        duration: TimeInterval,
        patient: Patient?,
        status: Status = .none
    ) {
        self.id = id
        self.scheduledTime = scheduledTime
        self.duration = duration
        self.patient = patient
        self.status = status
    }

    public init(from short: PatientAppointment.Short, patient: Patient? = nil) {
        self.id = short.id
        self.scheduledTime = short.scheduledTime
        self.duration = short.duration
        self.patient = patient
        self.status = short.status
    }

    public var short: PatientAppointment.Short {
        Short(id: id, scheduledTime: scheduledTime, duration: duration, patientId: patient?.id, status: status)
    }
    
    /// Update patient property with checking if there is already registered patient.
    /// - Parameter patient: New patient with updates (can be nil)
    public mutating func update(patient: Patient?) {
        if let patient = patient {
            guard self.patient == nil else { return }

            self.patient = patient
            status = .registered
        } else {
            self.patient = nil
            status = .cancelled
        }
    }
}

extension PatientAppointment {
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
}
