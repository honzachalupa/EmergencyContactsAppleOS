import Foundation
import MapKit

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
