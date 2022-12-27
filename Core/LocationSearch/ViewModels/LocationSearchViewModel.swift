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
	@Published var selectedLocation: Location?
	@Published var pickupTime: String?
	@Published var dropOffTime: String?

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
			self.selectedLocation = Location(title: localSearchCompletion.title, cooridate: coordinate)
		}
	}
	
	func locationSearch(forLocationSearchCompletion localSearchCompletion: MKLocalSearchCompletion, completionHandler: @escaping MKLocalSearch.CompletionHandler) {
		let searchRequest = MKLocalSearch.Request()
		searchRequest.naturalLanguageQuery = localSearchCompletion.title.appending(localSearchCompletion.subtitle)
		
		let search = MKLocalSearch(request: searchRequest)
		search.start(completionHandler: completionHandler)
	}
	
	func computeRidePrice(forType rideType: RideType) -> Double {
		guard let selectedLocationCoordinate = selectedLocation?.cooridate else { return 0.0 }
		guard let userCoordinate = self.userLocation else { return 0.0 }
		
		let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
		let destination = CLLocation(latitude: selectedLocationCoordinate.latitude, longitude: selectedLocationCoordinate.longitude)
		
		let tripDistanceInMeters = userLocation.distance(from: destination)
		
		return rideType.computePrice(for: tripDistanceInMeters)
	}
	
	func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to userDestination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
		let userLocationPlacemark = MKPlacemark(coordinate: userLocation)
		let userDestinationPlacemark = MKPlacemark(coordinate: userDestination)
		let request = MKDirections.Request()
		
		request.source = MKMapItem(placemark: userLocationPlacemark)
		request.destination = MKMapItem(placemark: userDestinationPlacemark)
		
		let directions = MKDirections(request: request)
		directions.calculate { response, error in
			if let error = error {
				print("ERROR: directions.calculate error: \(error.localizedDescription)")
				
				return
			}
			
			guard let route = response?.routes.first else { return }
			self.configurePickupAndDropOffTimes(with: route.expectedTravelTime)
			
			completion(route)
		}
	}
	
	func configurePickupAndDropOffTimes(with expectedTravelTime: Double) {
		let formatter = DateFormatter()
		formatter.dateFormat = "hh:mm a"
		
		pickupTime = formatter.string(from: Date())
		dropOffTime = formatter.string(from: Date() + expectedTravelTime)
	}
}

// MARK: Extensions

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
	
	// MARK: MKLocalSearchCompleterDelegate
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		self.results = completer.results
	}
}
