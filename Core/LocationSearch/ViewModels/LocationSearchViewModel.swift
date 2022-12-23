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
				print("Location search failed. Error: \(error.localizedDescription)")
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
}

// MARK: Extensions

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
	
	// MARK: MKLocalSearchCompleterDelegate
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		self.results = completer.results
	}
}
