//
//  LocationManager.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject {
	
	// MARK: Properties
	
	private let locationManager = CLLocationManager()
	
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
		guard !locations.isEmpty else { return }
		locationManager.stopUpdatingLocation()
	}
}
