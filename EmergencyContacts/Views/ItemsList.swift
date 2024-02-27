import SwiftUI
import MapKit

struct ItemsListView: View {
    let locationManager = CLLocationManager()
    
    @State var filteredDataGrouped: [DataItem.CategoryType: [DataItem]] = [:]
    
    var body: some View {
        VStack {
            ItemsList_Filter(filteredDataGrouped: $filteredDataGrouped)
                .frame(height: 170)
            
            List {
                ForEach(filteredDataGrouped.keys.sorted(), id: \.self) { category in
                    Section {
                        ForEach(filteredDataGrouped[category] ?? [], id: \.name) { item in
                            ItemsList_ItemView(item: item)
                        }
                    } header: {
                        HStack {
                            Image(systemName: "cross.fill")
                                .foregroundColor(getCategoryColor(category))
                            
                            Text(getCategoryLabel(category))
                        }
                    }
                }
            }
            .listStyle(.sidebar)
        }
        /* .onAppear(perform: {
            let place = filteredDataGrouped["hospital"]!.first!
            let placeCoordinates = place.coordinates
            
            print(
                locationManager.location!.coordinate,
                filteredDataGrouped["hospital"]!.first!.coordinates,
                locationManager.location!.distance(
                    from: CLLocation(
                        latitude: placeCoordinates.latitude,
                        longitude: placeCoordinates.latitude
                    )
                ) / 1000,
                CLLocation(
                    latitude: placeCoordinates.latitude,
                    longitude: placeCoordinates.latitude
                ).distance(from: locationManager.location!) / 1000
            )
        })
        .onChange(of: store.data) {
            let place = filteredDataGrouped["hospital"]!.first!
            let placeCoordinates = place.coordinates
            
            print(
                locationManager.location!.coordinate,
                filteredDataGrouped["hospital"]!.first!.coordinates,
                locationManager.location!.distance(
                    from: CLLocation(
                        latitude: placeCoordinates.latitude,
                        longitude: placeCoordinates.latitude
                    )
                ) / 1000,
                CLLocation(
                    latitude: placeCoordinates.latitude,
                    longitude: placeCoordinates.latitude
                ).distance(from: locationManager.location!) / 1000
            )
        } */
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView()
    }
}
