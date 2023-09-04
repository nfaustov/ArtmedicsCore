import Foundation

public struct Doctor: Employee, Codable, Hashable, Identifiable {
    public enum Specialization: String, Codable, CaseIterable, Hashable, Identifiable {
        case gynecologist = "Гинеколог"
        case therapist = "Терапевт"
        case urologist = "Уролог"
        case ultrasound = "Врач УЗИ"
        case gastroenterologist = "Гастроэнтеролог"
        case endocrinologist = "Эндокринолог"
        case cardiologist = "Кардиолог"
        case vascularSurgeon = "Сосудистый хирург"
        case functionalDiagnostics = "Врач функциональной диагностики"
        case neurologist = "Невролог"

        public var id: Self {
            self
        }
    }

    public let id: UUID
    public var secondName: String
    public var firstName: String
    public var patronymicName: String
    public var phoneNumber: String
    public var birthDate: Date
    public var specialization: Specialization
    public var basicServiceId: String
    public var serviceDuration: TimeInterval
    public var defaultCabinet: Int
    public var salary: Salary
    public var balance: Double
    public var info: String
    public var imageUrl: String

    public init(
        id: UUID = UUID(),
        secondName: String,
        firstName: String,
        patronymicName: String,
        phoneNumber: String,
        birthDate: Date,
        specialization: Specialization,
        basicServiceId: String = "",
        serviceDuration: TimeInterval,
        defaultCabinet: Int,
        salary: Salary,
        balance: Double = 0,
        info: String = "",
        imageUrl: String = ""
    ) {
        self.id = id
        self.secondName = secondName
        self.firstName = firstName
        self.patronymicName = patronymicName
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
        self.specialization = specialization
        self.basicServiceId = basicServiceId
        self.serviceDuration = serviceDuration
        self.defaultCabinet = defaultCabinet
        self.salary = salary
        self.balance = balance
        self.info = info
        self.imageUrl = imageUrl
    }

    public var employee: AnyEmployee {
        AnyEmployee(
            id: id,
            secondName: secondName,
            firstName: firstName,
            patronymicName: patronymicName,
            phoneNumber: phoneNumber,
            balance: balance,
            salary: salary
        )
    }
}
