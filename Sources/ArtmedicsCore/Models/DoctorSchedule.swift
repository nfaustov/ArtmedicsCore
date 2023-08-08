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

    /// Updates number of patient appointments, excluding impact on already scheduled patients.
    public mutating func updateAppointments() {
        if patientAppointments.compactMap({ $0.patient }).isEmpty {
            patientAppointments.removeAll()
            createAppointments()
        } else {
            patientAppointments.removeAll(where: { $0.patient == nil })
            editAppointments()
            patientAppointments.sort { $0.scheduledTime < $1.scheduledTime }
        }
    }

    /// Replace appointments with new appointment at the same scheduled time.
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
}

// MARK: - Private methods

private extension DoctorSchedule {
    mutating func addingAppointmentIteration(_ appointmentTime: inout Date) {
        let appointment = PatientAppointment(
            scheduledTime: appointmentTime,
            duration: doctor.serviceDuration,
            patient: nil
        )
        patientAppointments.append(appointment)
        appointmentTime.addTimeInterval(doctor.serviceDuration)
    }

    mutating func createAppointments() {
        var appointmentTime = starting

        repeat {
            addingAppointmentIteration(&appointmentTime)
        } while appointmentTime < ending
    }

    mutating func editAppointments() {
        guard let firstPatientStarting = patientAppointments.first(where: { $0.patient != nil })?.scheduledTime,
              let lastPatient = patientAppointments.last(where: { $0.patient != nil }) else {
            return
        }

        var appointmentTime = starting

        while appointmentTime < firstPatientStarting {
            addingAppointmentIteration(&appointmentTime)
        }

        appointmentTime = lastPatient.scheduledTime.addingTimeInterval(lastPatient.duration)

        while appointmentTime < ending {
            addingAppointmentIteration(&appointmentTime)
        }
    }
}
