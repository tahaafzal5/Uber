//
//  LocationManager.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
	
	// MARK: Properties
	
	private let locationManager = CLLocationManager()
	
	static let shared = LocationManager()
	
	@Published var userLocation: CLLocationCoordinate2D?
	
	// MARK: Constructors
	
	override init() {
		super.init()
		locationManager.delegate = self
		
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 1
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
}

// MARK: Extensions

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		self.userLocation = location.coordinate
		locationManager.stopUpdatingLocation()
	}
}
