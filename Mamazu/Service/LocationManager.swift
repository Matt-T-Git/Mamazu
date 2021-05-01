//
//  LocationManager.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 18.03.2021.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    
    @AppStorage("city") var city = "-"
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    @Published var locationStatus: CLAuthorizationStatus? {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var lastLocation: CLLocation? {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var isLocated: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
        
    }
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private let locationManager = CLLocationManager()
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            guard let pm = placemarks?.first else { return }
            let city = "\(pm.administrativeArea!) - \(pm.locality!)"
            DispatchQueue.main.async {
                self.city = city
                self.isLocated = true
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            manager.stopUpdatingLocation()
        }
    }
    
    func start() {
        self.manager.startUpdatingLocation()
    }
    
    func stop() {
        self.manager.stopUpdatingLocation()
    }
    
    func requestAuth() {
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
}
