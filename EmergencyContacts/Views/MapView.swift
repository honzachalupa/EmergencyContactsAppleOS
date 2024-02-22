import SwiftUI
import MapKit

struct MapView: View {
    var data: [DataItem.CategoryType: [DataItem]]
    
    var body: some View {
        Map {
            ForEach(data.keys.sorted(), id: \.self) { category in
                ForEach(data[category] ?? [], id: \.name) { item in
                    Marker(
                        item.name,
                        systemImage: "cross.fill",
                        coordinate: CLLocationCoordinate2D(
                            latitude: item.coordinates[0],
                            longitude: item.coordinates[1]
                        )
                    ).tint(getCategoryColor(item.category))
                }
            }
        }
        .mapControlVisibility(.hidden)
    }
}
