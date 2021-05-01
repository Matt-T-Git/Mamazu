//
//  DetailedMapView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 28.03.2021.
//

import SwiftUI
import MapKit

import SwiftUI
import MapKit


struct DetailedMapView: UIViewRepresentable {
    
    var latitude: Double
    var longitude: Double
    var title: String
    
    @StateObject var manager = LocationManager()
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
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
        
        let center = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010)
        let region = MKCoordinateRegion(center: center, span: span)
        view.setRegion(region, animated: true)
        
        let receivedLocation = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = receivedLocation
        annotation.title = title
        view.addAnnotation(annotation)
    }
    
    func makeCoordinator() -> DetailMapViewCoordinator {
        return DetailMapViewCoordinator(mapView: self)
    }
}

class DetailMapViewCoordinator: NSObject, MKMapViewDelegate {
    
    let mapView:DetailedMapView
    init(mapView: DetailedMapView) {
        self.mapView = mapView
    }
    
    
    
    @objc func dismiss() {
        self.mapView.presentationMode.wrappedValue.dismiss()
    }
}
