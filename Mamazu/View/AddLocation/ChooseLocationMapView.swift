//
//  ChooseLocationMapView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 24.03.2021.
//
import SwiftUI
import MapKit


struct ChooseLocationMapView: UIViewRepresentable {
    
    @Binding var latitude: Double
    @Binding var longitude: Double
    @Binding var isSelected: Bool
    
    @State var locations = [CLLocationCoordinate2D]()
    @StateObject var manager = LocationManager()
    var title: String = LocalizedString.mapLocationChosen
    
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let longPressed = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(MapViewCoordinator.addPin(gesture:)))
        mapView.addGestureRecognizer(longPressed)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.mapType = MKMapType.standard // (satellite)
        view.showsUserLocation = true
        
        let closeButton = UIImage(imageLiteralResourceName: "Close")
        let button = UIButton(type: .system)
        button.setImage(closeButton.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(context.coordinator, action: #selector(MapViewCoordinator.dismiss), for: .touchUpInside)
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 45),
            button.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        // 2
        var center = CLLocationCoordinate2D()
        
        if !locations.isEmpty {
            center = CLLocationCoordinate2D(latitude: locations.first!.latitude,longitude: locations.first!.longitude)
        }else{
            center = CLLocationCoordinate2D(
                latitude: view.userLocation.coordinate.latitude, longitude: view.userLocation.coordinate.longitude)
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010)
        let region = MKCoordinateRegion(center: center, span: span)
        view.setRegion(region, animated: true)
        
        // 4
        if !locations.isEmpty {
            let mylocation = CLLocationCoordinate2D(latitude: locations.first!.latitude,longitude: locations.first!.longitude)
            let annotation = MKPointAnnotation()
            view.annotations.forEach { (anno) in
                view.removeAnnotation(anno)
            }
            annotation.coordinate = mylocation
            annotation.title = title
            view.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(mapView: self)
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
    let mapView:ChooseLocationMapView
    init(mapView: ChooseLocationMapView) {
        self.mapView = mapView
    }
    
    @objc func addPin(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            let touchPoint = gesture.location(in: gesture.view)
            let newCoordinates = (gesture.view as? MKMapView)?.convert(touchPoint, toCoordinateFrom: gesture.view)
            guard let _newCoordinates = newCoordinates else { return }
            self.mapView.locations.removeAll()
            self.mapView.locations.append(CLLocationCoordinate2D(latitude: _newCoordinates.latitude, longitude: _newCoordinates.longitude))
            self.mapView.latitude = _newCoordinates.latitude
            self.mapView.longitude = _newCoordinates.longitude
            self.mapView.isSelected = true
        }
    }
    
    @objc func dismiss() {
        self.mapView.presentationMode.wrappedValue.dismiss()
    }
}
