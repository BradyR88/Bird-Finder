//
//  DeviceLocationService.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/26/22.
//

import Combine
import CoreLocation

class DeviceLocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    //    var coordinatesPublicher = PassthroughSubject<CLLocationCoordinate2D, Error>()
    //
    //    var deniedLocationAccessPublisher = PassthroughSubject<Void, Never>()
    
    var authorizationState = CLAuthorizationStatus.notDetermined
    var lat: Double = 0
    var lng: Double = 0
    
    private override init() {
        super.init()
    }
    
    static let shared = DeviceLocationService()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.delegate = self
        return manager
    }()
    
    func requestGeolocationPermission() {
        // request permition for the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        self.authorizationState = locationManager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.first
        
        if userLocation != nil {
            locationManager.stopUpdatingLocation()
            
            self.lat = userLocation!.coordinate.latitude
            self.lng = userLocation!.coordinate.longitude
        }
    }
}

