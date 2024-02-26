import SwiftUI
import MapKit

struct ItemsList_ItemView: View {
    var item: DataItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            
            Text("\(item.address.street), \(item.address.district)")
            
            if let note = item.address.note {
                Text("(\(note))")
                    .opacity(0.6)
            }
            
            // LookAroundView(item: item)
            
            Spacer()
            
            HStack() {
                Spacer()
            
                NavigateButton(name: item.name, coordinates: item.coordinates)
                    .buttonStyle(.bordered)
                WebButton(url: item.contact.url)
                    .buttonStyle(.bordered)
                CallButton(phoneNumbers: item.contact.phoneNumbers)
                    .buttonStyle(.bordered)
            }
        }
        .padding(.vertical, 10)
    }
}

struct NavigateButton: View {
    let name: DataItem.NameType;
    let coordinates: DataItem.CoordinatesType;
    
    var body: some View {
        Button("Navigate") {
            let destination = MKMapItem(
                placemark: MKPlacemark(
                    coordinate: coordinates
                )
            )
            
            destination.name = name
                    
            MKMapItem.openMaps(
              with: [destination],
              launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            )
        }
    }
}

struct WebButton: View {
    let url: DataItem.ContactType.UrlType

    var body: some View {
        if let checkedUrl = url,
           let urlString = URL(string: checkedUrl) {
            Button("Website") {
                UIApplication.shared.open(urlString)
            }
        }
    }
}

struct CallButton: View {
    let phoneNumbers: DataItem.ContactType.PhoneNumbersType

    var body: some View {
        if phoneNumbers.count == 1, let phoneURL = URL(string: "tel://\(formatPhoneNumber(phoneNumbers[0]))") {
            Button("Call") {
                UIApplication.shared.open(phoneURL)
            }
        } else if phoneNumbers.count > 1 {
            Menu {
                ForEach(phoneNumbers, id: \.self) { phoneNumber in
                    if let phoneURL = URL(string: "tel://\(formatPhoneNumber(phoneNumber))") {
                        Button(formatPhoneNumber(phoneNumber)) {
                            UIApplication.shared.open(phoneURL)
                        }
                    }
                }
            } label: {
                Text("Call")
            }
        }
    }
}

struct ItemsList_ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsList_ItemView(item: mockedItems.first!)
    }
}
