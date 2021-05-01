//
//  MapView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 19.03.2021.
//

import SwiftUI
import MapKit

struct MamazuMapView: UIViewRepresentable {
    
    var latitude: Double
    var longitude: Double
    var title: String
    
    let map = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        return map
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
        view.mapType = MKMapType.standard
        let receivedLocation = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        
        let coordinate = CLLocationCoordinate2D(
            latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = receivedLocation
        
        annotation.title = title
        view.addAnnotation(annotation)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MamazuMapView(latitude: 36.85789856768421, longitude: 30.76025889471372, title: "Junior")
    }
}
