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

    public init(from dbModel: DoctorSchedule.DBModel, doctor: Doctor, patientAppointments: [PatientAppointment]) {
        self.id = dbModel.id
        self.doctor = doctor
        self.cabinet = dbModel.cabinet
        self.starting = dbModel.starting
        self.ending = dbModel.ending
        self.patientAppointments = patientAppointments
    }

    public var dbModel: DoctorSchedule.DBModel {
        DBModel(
            id: id,
            doctorId: doctor.id,
            cabinet: cabinet,
            starting: starting,
            ending: ending
        )
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

    /// Split appointment to several appointments with doctor service duration.
    /// - Parameter appointment: Appointment for splitting.
    /// - Returns: Array of empty appointments which have been created on time interval of duration of given appointment.
    public func splitToBasicDurationAppointments(_ appointment: PatientAppointment) -> [PatientAppointment.DBModel] {
        if appointment.duration > doctor.serviceDuration {
            return createAppointments(
                on: DateInterval(start: appointment.scheduledTime, duration: appointment.duration)
            )
        } else {
            return [
                PatientAppointment.DBModel(
                        scheduledTime: appointment.scheduledTime,
                        duration: appointment.duration,
                        status: .none
                )
            ]
        }
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

    func createAppointments(on interval: DateInterval) -> [PatientAppointment.DBModel] {
        var appointmentTime = interval.start
        var appointments = [PatientAppointment]()

        repeat {
            let appointment = PatientAppointment(
                scheduledTime: appointmentTime,
                duration: doctor.serviceDuration,
                patient: nil)
            appointments.append(appointment)
            appointmentTime.addTimeInterval(doctor.serviceDuration)
        } while appointmentTime < interval.end

        return appointments.map { $0.dbModel }
    }
}
