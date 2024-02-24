import Foundation

let mockedItems: [DataItem.CategoryType: [DataItem]] = [
    "hospital": [
        DataItem(
            id: 101,
            category: "hospital",
            name: "Name 1",
            address: Address(
                street: "Address steet",
                district: "Address district"
            ),
            contact: Contact(
                phoneNumbers: [123456789],
                emailAddess: "email@email.com",
                url: "https:/www.url.com/"
            ),
            coordinates: [50.08804, 14.42076]
        ),
        DataItem(
            id: 102,
            category: "hospital",
            name: "Name 2",
            address: Address(
                street: "Address steet",
                district: "Address district"
            ),
            contact: Contact(
                phoneNumbers: [123456789],
                emailAddess: "email@email.com",
                url: "https:/www.url.com/"
            ),
            coordinates: [50.08804, 14.42076 + 1]
        )
    ],
    "pharmacy": [
        DataItem(
            id: 201,
            category: "pharmacy",
            name: "Name 3",
            address: Address(
                street: "Address steet",
                district: "Address district"
            ),
            contact: Contact(
                phoneNumbers: [123456789],
                emailAddess: "email@email.com",
                url: "https:/www.url.com/"
            ),
            coordinates: [50.08804 - 1, 14.42076]
        ),
        DataItem(
            id: 202,
            category: "pharmacy",
            name: "Name 4",
            address: Address(
                street: "Address steet",
                district: "Address district"
            ),
            contact: Contact(
                phoneNumbers: [123456789],
                emailAddess: "email@email.com",
                url: "https:/www.url.com/"
            ),
            coordinates: [50.08804 - 1, 14.42076 + 1]
        )
    ],
    "vet": [
        DataItem(
            id: 301,
            category: "vet",
            name: "Name 5",
            address: Address(
                street: "Address steet",
                district: "Address district"
            ),
            contact: Contact(
                phoneNumbers: [123456789],
                emailAddess: "email@email.com",
                url: "https:/www.url.com/"
            ),
            coordinates: [50.08804 - 2, 14.42076]
        ),
        DataItem(
            id: 302,
            category: "vet",
            name: "Name 6",
            address: Address(
                street: "Address steet",
                district: "Address district"
            ),
            contact: Contact(
                phoneNumbers: [123456789],
                emailAddess: "email@email.com",
                url: "https:/www.url.com/"
            ),
            coordinates: [50.08804 - 2, 14.42076 + 1]
        )
    ]
]
