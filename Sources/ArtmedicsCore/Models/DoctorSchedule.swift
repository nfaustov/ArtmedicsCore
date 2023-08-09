import Foundation

public struct DoctorSchedule: Codable, Equatable, Hashable, Identifiable {
    public let id: UUID
    public let doctor: Doctor
    public var cabinet: Int
    public var starting: Date
    public var ending: Date
    public var patientAppointments: [PatientAppointment]

    public init(
        id: UUID = UUID(),
        doctor: Doctor,
        starting: Date,
        ending: Date,
        cabinet: Int,
        patientAppointments: [PatientAppointment] = []
    ) {
        self.id = id
        self.doctor = doctor
        self.cabinet = cabinet
        self.starting = starting
        self.ending = ending
        self.patientAppointments = patientAppointments

        if self.patientAppointments.isEmpty {
            createAppointments()
        }
    }

    public var scheduledPatients: Int {
        patientAppointments
            .compactMap { $0.patient }
            .count
    }

    public var availableAppointments: Int {
        patientAppointments.count - scheduledPatients
    }

    public var duration: TimeInterval {
        ending.timeIntervalSince(starting)
    }

    /// Updates number of patient appointments, based on starting and ending properties.
    /// Works only if appointments doesn't have a patients.
    public mutating func updateAppointments() {
        guard patientAppointments.compactMap({ $0.patient }).isEmpty else {
            preconditionFailure("Невозможно выполнить операцию, в расписании есть записанные пациенты.")
        }

        patientAppointments.removeAll()
        createAppointments()
    }

    /// Replace appointment with new appointment at the same scheduled time.
    /// - Parameters:
    ///   - newAppointment: New appointment to update
    public mutating func updateAppointments(with newAppointment: PatientAppointment) {
        guard let index = patientAppointments.firstIndex(
            where: { $0.scheduledTime == newAppointment.scheduledTime }
        ) else {
            preconditionFailure("Время начала приема не соответствует расписанию.")
        }

        if newAppointment.duration == patientAppointments[index].duration {
            patientAppointments[index].patient = newAppointment.patient
        } else if newAppointment.duration > patientAppointments[index].duration {
            let crossedIndex = index + Int(newAppointment.duration / doctor.serviceDuration)
            precondition(
                crossedIndex <= patientAppointments.count,
                "Длительность приема выходит за рамки длительности расписания."
            )

            let replacedPatients = patientAppointments[index..<crossedIndex].compactMap { $0.patient }
            precondition(replacedPatients.isEmpty, "На данном интервале уже есть записанный пациент")

            patientAppointments.removeSubrange(index..<crossedIndex)
            patientAppointments.insert(newAppointment, at: index)
        } else {
            preconditionFailure(
                "Длительность приема слишком маленькая, необходимо по крайней мере \(doctor.serviceDuration / 60) мин."
            )
        }
    }

    /// Calculate available duration for patient's appointment.
    /// - Parameter appointment: Appointment for calculation.
    public func maxServiceDuration(for appointment: PatientAppointment) -> TimeInterval {
        if let nextReservedAppointment = patientAppointments
            .filter({ $0.scheduledTime > appointment.scheduledTime })
            .first(where: { $0.patient != nil }) {
            return nextReservedAppointment.scheduledTime.timeIntervalSince(appointment.scheduledTime)
        } else {
            return ending.timeIntervalSince(appointment.scheduledTime)
        }
    }
    
    /// Create new empty appointment at the begining of schedule, starting time shifts early on doctor's duration time interval.
    public mutating func extendStarting() {
        let patientAppointment = PatientAppointment(
            scheduledTime: starting.addingTimeInterval(-doctor.serviceDuration),
            duration: doctor.serviceDuration,
            patient: nil
        )
        starting = patientAppointment.scheduledTime
        patientAppointments.insert(patientAppointment, at: 0)
    }
    
    /// Create new empty appointment at the end of schedule, ending time shifts late on doctor's duration time interval.
    public mutating func extendEnding() {
        let patientAppointment = PatientAppointment(
            scheduledTime: ending,
            duration: doctor.serviceDuration,
            patient: nil
        )
        ending.addTimeInterval(patientAppointment.duration)
        patientAppointments.append(patientAppointment)
    }
}

// MARK: - Private methods

private extension DoctorSchedule {
    mutating func createAppointments() {
        var appointmentTime = starting

        repeat {
            let appointment = PatientAppointment(
                scheduledTime: appointmentTime,
                duration: doctor.serviceDuration,
                patient: nil
            )
            patientAppointments.append(appointment)
            appointmentTime.addTimeInterval(doctor.serviceDuration)
        } while appointmentTime < ending
    }
}
