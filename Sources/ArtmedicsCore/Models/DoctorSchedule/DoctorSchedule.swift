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

    public init(from short: DoctorSchedule.Short, patientAppointments: [PatientAppointment]) {
        self.id = short.id
        self.doctor = short.doctor
        self.cabinet = short.cabinet
        self.starting = short.starting
        self.ending = short.ending
        self.patientAppointments = patientAppointments
    }

    public var short: DoctorSchedule.Short {
        Short(id: id, doctor: doctor, cabinet: cabinet, starting: starting, ending: ending)
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
    ///   - newAppointment: New appointment with updates
    public mutating func replaceAppointments(with newAppointment: PatientAppointment) -> [PatientAppointment.Short] {
        guard let index = patientAppointments.firstIndex(
            where: { $0.scheduledTime == newAppointment.scheduledTime }
        ) else { return [] }

        if newAppointment.duration == patientAppointments[index].duration {
            patientAppointments[index].update(patient: newAppointment.patient)
            return []
        } else if newAppointment.duration > patientAppointments[index].duration {
            let deletingAppointments = patientAppointments
                .filter { (newAppointment.scheduledTime..<newAppointment.endTime).contains($0.scheduledTime)
                }
                .dropFirst()

            guard deletingAppointments.compactMap({ $0.patient }).isEmpty else { return [] }

            patientAppointments.removeAll(where: { deletingAppointments.contains($0) })
            patientAppointments[index].update(patient: newAppointment.patient)
            patientAppointments[index].duration = newAppointment.duration

            return deletingAppointments.map { $0.short }
        } else {
            return []
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
    
    /// Split long appointment to many appointments with doctor service duration.
    /// Works only if appointment doesn't have a patient and appointment duration is bigger than doctor service duration.
    /// - Parameter appointment: Appointment for split.
    public func splitToBasicDurationAppointments(_ appointment: PatientAppointment) -> [PatientAppointment.Short] {
        guard appointment.status == .cancelled else { return [] }

        if appointment.duration > doctor.serviceDuration {
            return createAppointments(
                on: DateInterval(start: appointment.scheduledTime, duration: appointment.duration)
            )
        } else {
            return [
                PatientAppointment.Short(
                    scheduledTime: appointment.scheduledTime,
                    duration: appointment.duration,
                    status: .none
                )
            ]
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
        ending = patientAppointment.endTime
        patientAppointments.append(patientAppointment)
    }
    
    /// Remove first appointment in schedule, starting time shifts late on deleted appointment duration interval.
    public mutating func removeFirstAppointment() {
        if let firstAppointment = patientAppointments.first,
           let secondAppointment = patientAppointments.dropFirst().first {
            guard firstAppointment.patient == nil else { return }

            patientAppointments.removeFirst()
            starting = secondAppointment.scheduledTime
        }
    }
    
    /// Remove last appointment in schedule, ending time shifts early on deleted appointment duration interval.
    public mutating func removeLastAppointment() {
        if let lastAppointment = patientAppointments.last,
           let lastButOneAppointment = patientAppointments.dropLast().last {
            guard lastAppointment.patient == nil else { return }

            patientAppointments.removeLast()
            ending = lastButOneAppointment.endTime
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

    func createAppointments(on interval: DateInterval) -> [PatientAppointment.Short] {
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

        return appointments.map { $0.short }
    }
}
