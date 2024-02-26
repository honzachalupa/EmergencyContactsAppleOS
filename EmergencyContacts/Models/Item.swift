import MapKit

struct Address: Decodable {
    typealias StreetType = String
    typealias DiscrictType = String
    typealias NoteType = String?
    
    let street: StreetType
    let district: DiscrictType
    let note: NoteType
}

struct Contact: Decodable {
    typealias PhoneNumberType = Int
    typealias PhoneNumbersType = [PhoneNumberType]
    typealias EmailAddressType = String?
    typealias UrlType = String?
    
    let phoneNumbers: PhoneNumbersType
    let emailAddess: EmailAddressType
    let url: UrlType
}

struct DataItem: Decodable, Identifiable {
    typealias IdType = Int
    typealias CategoryType = String
    typealias NameType = String
    typealias AddressType = Address
    typealias ContactType = Contact
    typealias CoordinatesType = CLLocationCoordinate2D

    let id: IdType
    let category: CategoryType
    let name: NameType
    let address: AddressType
    let contact: ContactType
    let coordinates: CoordinatesType
}

private enum CodingKeys: String, CodingKey {
    case id
    case category
    case name
    case address
    case contact
    case coordinates
}

extension CLLocationCoordinate2D: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let latitude = try container.decode(Double.self)
        let longitude = try container.decode(Double.self)
        self.init(latitude: latitude, longitude: longitude)
    }
}

extension DataItem {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(IdType.self, forKey: .id)
        category = try container.decode(CategoryType.self, forKey: .category)
        name = try container.decode(NameType.self, forKey: .name)
        address = try container.decode(AddressType.self, forKey: .address)
        contact = try container.decode(ContactType.self, forKey: .contact)
        coordinates = try container.decode(CoordinatesType.self, forKey: .coordinates)
    }
}

extension DataItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(category)
        hasher.combine(name)
        hasher.combine(address.street)
        hasher.combine(address.district)
        hasher.combine(address.note)
        hasher.combine(contact.phoneNumbers)
        hasher.combine(contact.emailAddess)
        hasher.combine(contact.url)
        hasher.combine(coordinates.latitude)
        hasher.combine(coordinates.longitude)
    }
}

extension DataItem: Equatable {
    static func == (lhs: DataItem, rhs: DataItem) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.category == rhs.category &&
            lhs.name == rhs.name &&
            lhs.address.street == rhs.address.street &&
            lhs.address.district == rhs.address.district &&
            lhs.address.note == rhs.address.note &&
            lhs.contact.phoneNumbers == rhs.contact.phoneNumbers &&
            lhs.contact.emailAddess == rhs.contact.emailAddess &&
            lhs.contact.url == rhs.contact.url &&
            lhs.coordinates.latitude == rhs.coordinates.latitude &&
            lhs.coordinates.longitude == rhs.coordinates.longitude
    }
}

let mockedItems: [DataItem] = [
    DataItem(
        id: 101,
        category: "hospital",
        name: "Name 1",
        address: Address(
            street: "Address steet",
            district: "Address district 1",
            note: "Note"
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddess: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804, longitude: 14.42076)
    ),
    DataItem(
        id: 102,
        category: "hospital",
        name: "Name 2",
        address: Address(
            street: "Address steet",
            district: "Address district 2",
            note: nil
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddess: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804, longitude: 14.42076 + 1)
    ),
    DataItem(
        id: 201,
        category: "pharmacy",
        name: "Name 3",
        address: Address(
            street: "Address steet",
            district: "Address district 1",
            note: nil
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddess: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804 - 1, longitude: 14.42076)
    ),
    DataItem(
        id: 202,
        category: "pharmacy",
        name: "Name 4",
        address: Address(
            street: "Address steet",
            district: "Address district 4",
            note: "Note"
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddess: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804 - 1, longitude: 14.42076 + 1)
    ),
    DataItem(
        id: 301,
        category: "vet",
        name: "Name 5",
        address: Address(
            street: "Address steet",
            district: "Address district 2",
            note: nil
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddess: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804 - 2, longitude: 14.42076)
    ),
    DataItem(
        id: 302,
        category: "vet",
        name: "Name 6",
        address: Address(
            street: "Address steet",
            district: "Address district 6",
            note: nil
        ),
        contact: Contact(
            phoneNumbers: [123456789],
            emailAddess: "email@email.com",
            url: "https:/www.url.com/"
        ),
        coordinates: CLLocationCoordinate2D(latitude: 50.08804 - 2, longitude: 14.42076 + 1)
    )
]
