import SwiftUI
import MapKit

struct LookAroundView: View {
    var item: DataItem
    
    @State private var lookAroundScene: MKLookAroundScene?
    
    func getLookAroundScene() {
        lookAroundScene = nil
        
        Task {
            let request = MKLookAroundSceneRequest(
                mapItem: MKMapItem(
                    placemark: MKPlacemark(
                        coordinate: CLLocationCoordinate2D(
                            latitude: 50.06936,
                            longitude: 14.39186
                        )
                    )
                )
            )
            
            lookAroundScene = try? await request.scene
        }
    }
    
    var body: some View {
        VStack {
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
            }
        }
        .onAppear() {
            getLookAroundScene()
        }
    }
}

#Preview {
    LookAroundView(item: mockedItems.first!)
}
