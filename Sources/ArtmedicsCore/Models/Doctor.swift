import Foundation

public struct Doctor: Codable, Hashable, Identifiable {
    public let id: UUID
    public var secondName: String
    public var firstName: String
    public var patronymicName: String
    public var phoneNumber: String
    public var birthDate: Date?
    public var specialization: String
    public var basicService: String?
    public var serviceDuration: TimeInterval
    public var defaultCabinet: Int?
    public var info: String?
    public var imageData: Data?

    public var fullName: String {
        secondName + " " + firstName + " " + patronymicName
    }

    public var initials: String {
        guard let firstNameLetter = firstName.first,
              let patronymicNameLetter = patronymicName.first else { return secondName }

        return "\(secondName) \(firstNameLetter).\(patronymicNameLetter)"
    }

    public init(
        id: UUID = UUID(),
        secondName: String,
        firstName: String,
        patronymicName: String,
        phoneNumber: String,
        birthDate: Date?,
        specialization: String,
        basicService: String?,
        serviceDuration: TimeInterval,
        defaultCabinet: Int? = nil,
        info: String? = nil,
        imageData: Data? = nil
    ) {
        self.id = id
        self.secondName = secondName
        self.firstName = firstName
        self.patronymicName = patronymicName
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
        self.specialization = specialization
        self.basicService = basicService
        self.serviceDuration = serviceDuration
        self.defaultCabinet = defaultCabinet
        self.info = info
        self.imageData = imageData
    }
}
