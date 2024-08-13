import SwiftUI
import MapKit
import CoreLocation

// Represents a letterbox annotation on the map
struct LetterboxAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}

// Main view that contains the map
struct MapContainerView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var annotations: [LetterboxAnnotation] = []

    // Array of tuples to represent letterboxes
    let letterboxes: [(boxName: String, location: String)]

    var body: some View {
        MapView(region: $region, annotations: annotations)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                setAnnotations()
                if let userLocation = locationManager.location?.coordinate {
                    region.center = userLocation
                }
            }
    }

    // Convert letterboxes to map annotations
    private func setAnnotations() {
        annotations = letterboxes.compactMap { letterbox in
            guard let coordinate = getCoordinate(from: letterbox.location) else { return nil }
            return LetterboxAnnotation(coordinate: coordinate, title: letterbox.boxName)
        }
    }

    // Convert a location string to CLLocationCoordinate2D
    private func getCoordinate(from location: String) -> CLLocationCoordinate2D? {
        let components = location.split(separator: ",")
        guard components.count == 2,
              let latitude = Double(components[0].trimmingCharacters(in: .whitespaces)),
              let longitude = Double(components[1].trimmingCharacters(in: .whitespaces)) else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// Represents the MapView with annotations
struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    let annotations: [LetterboxAnnotation]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        mapView.addAnnotations(annotations.map { annotation -> MKPointAnnotation in
            let pin = MKPointAnnotation()
            pin.coordinate = annotation.coordinate
            pin.title = annotation.title
            return pin
        })
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations.map { annotation -> MKPointAnnotation in
            let pin = MKPointAnnotation()
            pin.coordinate = annotation.coordinate
            pin.title = annotation.title
            return pin
        })
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView.canShowCallout = true
            return annotationView
        }
    }
}

// Manages the user's location
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var location: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}

// Preview for the MapContainerView
struct MapContainerView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data for preview
        let sampleLetterboxes = [
            (boxName: "Sample Box 1", location: "37.7749,-122.4194"),
            (boxName: "Sample Box 2", location: "37.7849,-122.4294")
        ]
        
        MapContainerView(letterboxes: sampleLetterboxes)
    }
}
