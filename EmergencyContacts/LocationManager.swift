import SwiftUI
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?

    @Published var position = MapCameraPosition.region(
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

    var binding: Binding<MapCameraPosition> {
        Binding {
            self.position
        } set: { newPosition in
            self.position = newPosition
        }
    }

    func checkIfLocationIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            print("Show an alert letting them know this is off")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let previousAuthorizationStatus = manager.authorizationStatus
        
        manager.requestWhenInUseAuthorization()
        
        if manager.authorizationStatus != previousAuthorizationStatus {
            checkLocationAuthorization()
        }
    }

    private func checkLocationAuthorization() {
        print(0, "here")
        
        guard let location = locationManager else {
            return
        }
        
        print(1, location.authorizationStatus)

        switch location.authorizationStatus {
            case .notDetermined:
                print("Location authorization is not determined.")
            case .restricted:
                print("Location is restricted.")
            case .denied:
                print("Location permission denied.")
            case .authorizedAlways, .authorizedWhenInUse:
                print(2, location)
            
                if let location = location.location {
                    position = MapCameraPosition.userLocation(followsHeading: true, fallback: MapCameraPosition.automatic)
                    
                    print(position)
                }
            default:
                break
            }
    }
}
