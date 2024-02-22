struct DataItem: Decodable {
    typealias CategoryType = String
    typealias NameType = String
    typealias AddressType = Address
    typealias ContactType = Contact
    typealias CoordinatesType = [Double]
    typealias UrlType = String
    
    let category: CategoryType
    let name: NameType
    let address: AddressType
    let contact: ContactType
    let coordinates: CoordinatesType
}

struct Address: Decodable {
    let street: String
    let district: String
    let city: String
}

struct Contact: Decodable {
    let phoneNumbers: [Int]
    let emailAddess: String?
    let url: String?
}
