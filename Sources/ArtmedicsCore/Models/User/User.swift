import Foundation

public struct User: Employee, Codable, Hashable, Identifiable {
    public let id: UUID
    public var secondName: String
    public var firstName: String
    public var patronymicName: String
    public var phoneNumber: String
    public var birthDate: Date
    public var salary: Salary
    public var agentFee: Double
    public var balance: Double
    public var imageUrl: String

    public init(
        id: UUID = UUID(),
        secondName: String,
        firstName: String,
        patronymicName: String,
        phoneNumber: String,
        birthDate: Date,
        salary: Salary = .hourly(amount: 150),
        agentFee: Double = 0,
        balance: Double = 0,
        imageUrl: String = ""
    ) {
        self.id = id
        self.secondName = secondName
        self.firstName = firstName
        self.patronymicName = patronymicName
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
        self.salary = salary
        self.agentFee = agentFee
        self.balance = balance
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
