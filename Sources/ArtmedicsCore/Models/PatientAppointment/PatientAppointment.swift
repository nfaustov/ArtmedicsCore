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

    public init(from dbModel: PatientAppointment.DBModel, patient: Patient? = nil) {
        self.id = dbModel.id
        self.scheduledTime = dbModel.scheduledTime
        self.duration = dbModel.duration
        self.patient = patient
        self.status = dbModel.status
    }

    public var dbModel: PatientAppointment.DBModel {
        DBModel(id: id, scheduledTime: scheduledTime, duration: duration, patientId: patient?.id, status: status)
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
