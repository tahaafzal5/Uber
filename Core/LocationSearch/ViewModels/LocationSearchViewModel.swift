//
//  LocationSearchViewModel.swift
//  Uber
//
//  Created by Taha Afzal on 12/22/22.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
	
	// MARK: Properties
	
	@Published var results = [MKLocalSearchCompletion]()
	@Published var selectedLocationCoordinates: CLLocationCoordinate2D?

	private let searchCompleter = MKLocalSearchCompleter()
	
	var queryFragment: String = "" {
		didSet {
			searchCompleter.queryFragment = queryFragment
		}
	}
	
	var userLocation: CLLocationCoordinate2D?
	
	// MARK: Constructors
	
	override init() {
		super.init()
		searchCompleter.delegate = self
		searchCompleter.queryFragment = queryFragment
	}
	
	// MARK: Functions
	
	func selectLocation(localSearchCompletion: MKLocalSearchCompletion) {
		locationSearch(forLocationSearchCompletion: localSearchCompletion) { response, error in
			
			if let error = error {
				print("ERROR: locationSearch error:  \(error.localizedDescription)")
				return
			}
			
			guard let item = response?.mapItems.first else { return }
			let coordinate = item.placemark.coordinate
			self.selectedLocationCoordinates = coordinate
		}
	}
	
	func locationSearch(forLocationSearchCompletion localSearchCompletion: MKLocalSearchCompletion, completionHandler: @escaping MKLocalSearch.CompletionHandler) {
		let searchRequest = MKLocalSearch.Request()
		searchRequest.naturalLanguageQuery = localSearchCompletion.title.appending(localSearchCompletion.subtitle)
		
		let search = MKLocalSearch(request: searchRequest)
		search.start(completionHandler: completionHandler)
	}
	
	func computeRidePrice(forType rideType: RideType) -> Double {
		guard let selectedLocationCoordinate = selectedLocationCoordinates else { return 0.0 }
		guard let userCoordinate = self.userLocation else { return 0.0 }
		
		let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
		let destination = CLLocation(latitude: selectedLocationCoordinate.latitude, longitude: selectedLocationCoordinate.longitude)
		
		let tripDistanceInMeters = userLocation.distance(from: destination)
		
		return rideType.computePrice(for: tripDistanceInMeters)
	}
}

// MARK: Extensions

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
	
	// MARK: MKLocalSearchCompleterDelegate
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		self.results = completer.results
	}
}
