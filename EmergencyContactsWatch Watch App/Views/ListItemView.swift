import SwiftUI
import MapKit

struct ListItemView: View {
    var item: DataItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name).font(.headline)
            
            Spacer()
            
            Text("\(item.address.street), \(item.address.district)")
            
            Spacer()
            
            NavigateButton(name: item.name, coordinates: item.coordinates)
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
        .buttonStyle(.bordered)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(item: mockedItems["hospital"]!.first!)
    }
}
