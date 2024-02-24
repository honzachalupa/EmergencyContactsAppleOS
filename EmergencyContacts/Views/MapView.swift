import SwiftUI
import MapKit

struct MapView: View {
    var data: [DataItem.CategoryType: [DataItem]]
    
    // @StateObject var locationManager = LocationManager()
    
    @State var position: MapCameraPosition = .userLocation(
        followsHeading: true, fallback: MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 50.08804,
                    longitude: 14.42076
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.2,
                    longitudeDelta: 0.2
                )
            )
        )
    )
    
    var body: some View {
            Map(
                position: $position,
                interactionModes: [.pan, .zoom]
            ) {
                UserAnnotation()
                
                ForEach(data.keys.sorted(), id: \.self) { category in
                    ForEach(data[category] ?? [], id: \.name) { item in
                        Annotation(
                            item.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: item.coordinates[0],
                                longitude: item.coordinates[1]
                            )
                        ) {
                            ZStack {
                                Color(.white)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(.infinity)
                                
                                Image(systemName: "cross.fill")
                                    .foregroundColor(getCategoryColor(item.category))
                            }
                            .padding(.all, 20)
                        }
                    }
                }
            }
            //.edgesIgnoringSafeArea(.all)
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
    }
}

#Preview {
    MapView(data: mockedItems)
}


/*
    import SwiftUI
    import MapKit

    struct MarkerItem: Identifiable {
     let id = UUID();
     let name: String;
     let category: String;
     let coordinates: CLLocationCoordinate2D
    }

    struct MapView: View {
     var data: [DataItem.CategoryType: [DataItem]]
     
     @State private var selectedItemId: UUID?
     @State private var selectedItem: MarkerItem?
     
     let markers = [
         MarkerItem(
             name: "Marker 1",
             category: "hospital",
             coordinates: CLLocationCoordinate2D(
                 latitude: 0,
                 longitude: 0
             )
         ),
         MarkerItem(
             name: "Marker 2",
             category: "pharmacy",
             coordinates: CLLocationCoordinate2D(
                 latitude: 1,
                 longitude: 1
             )
         )
     ];
     
     var body: some View {
         Map(selection: $selectedItemId) {
             ForEach(markers) { marker in
                 Marker(
                     marker.name,
                     systemImage: "cross.fill",
                     coordinate: marker.coordinates
                 )
                 .tint(getCategoryColor(marker.category))
             }
         }
         .onChange(of: selectedItemId, { _, id in
             selectedItem = markers.first(where: { $0.id == id})
         })
         .mapControlVisibility(.hidden)
         .navigationTitle(selectedItem.name)
     }
    }

    #Preview {
     MapView(data: mockedItems)
    }
*/
