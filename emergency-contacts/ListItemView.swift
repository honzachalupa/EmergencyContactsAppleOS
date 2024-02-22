import SwiftUI
import MapKit

struct ListItemView: View {
    var item: DataItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name).font(.headline)
            Text("\(item.address.street), \(item.address.district)")
            
            ControlGroup {
                NavigateButton(name: item.name, coordinates: item.coordinates)
                Divider()
                WebButton(url: item.contact.url);
                Divider()
                CallButton(phoneNumbers: item.contact.phoneNumbers);
            }
            .controlGroupStyle(.navigation)
            .background(.thickMaterial)
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding(.vertical, 10)
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
                    coordinate: CLLocationCoordinate2D(
                        latitude: coordinates[0],
                        longitude: coordinates[1]
                    )
                )
            )
            
            destination.name = name
                    
            MKMapItem.openMaps(
              with: [destination],
              launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            )
        }
        .padding(.leading, 10)
    }
}

struct WebButton: View {
    let url: String?

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
    let phoneNumbers: [Int]?

    var body: some View {
        if let phoneNumbers = phoneNumbers {
            if phoneNumbers.count == 1, let phoneURL = URL(string: "tel://\(formatPhoneNumber(phoneNumbers[0]))") {
                Button("Call") {
                    UIApplication.shared.open(phoneURL)
                }
                .padding(.trailing, 10)
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
                .padding(.trailing, 10)
            }
        }
    }
}
