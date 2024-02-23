import SwiftUI
import MapKit

struct MapView: View {
    var data: [DataItem.CategoryType: [DataItem]]
    
    var body: some View {
        Map {
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
        .mapControlVisibility(.hidden)
    }
}

#Preview {
    MapView(data: mockedItems)
}
