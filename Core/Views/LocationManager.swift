//
//  LocationManager.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject {
	private let locationManager = CLLocationManager()
	
	override init() {
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 1
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
}
