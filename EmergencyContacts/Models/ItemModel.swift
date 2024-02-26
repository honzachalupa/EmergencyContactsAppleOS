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
