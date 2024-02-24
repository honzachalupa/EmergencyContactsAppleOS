struct Address: Decodable {
    typealias StreetType = String
    typealias DiscrictType = String
    
    let street: StreetType
    let district: DiscrictType
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

struct DataItem: Decodable {
    typealias IdType = Int
    typealias CategoryType = String
    typealias NameType = String
    typealias AddressType = Address
    typealias ContactType = Contact
    typealias CoordinatesType = [Double]

    let id: IdType
    let category: CategoryType
    let name: NameType
    let address: AddressType
    let contact: ContactType
    let coordinates: CoordinatesType
}
