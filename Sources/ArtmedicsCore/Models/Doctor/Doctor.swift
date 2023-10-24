import Foundation

public struct Doctor: Employee, Codable, Hashable, Identifiable {
    public let id: UUID
    public var secondName: String
    public var firstName: String
    public var patronymicName: String
    public var phoneNumber: String
    public var birthDate: Date
    public var department: Department
    public var basicServiceId: String
    public var serviceDuration: TimeInterval
    public var defaultCabinet: Int
    public var salary: Salary
    public var agentFee: Double
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
        department: Department,
        basicServiceId: String = "",
        serviceDuration: TimeInterval,
        defaultCabinet: Int,
        salary: Salary,
        agentFee: Double = 0,
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
        self.department = department
        self.basicServiceId = basicServiceId
        self.serviceDuration = serviceDuration
        self.defaultCabinet = defaultCabinet
        self.salary = salary
        self.agentFee = agentFee
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
            salary: salary,
            agentFee: agentFee
        )
    }
}
