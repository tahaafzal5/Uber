//
//  MapViewRepresentable.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
	
	// MARK: Properties
	
	@EnvironmentObject var locationViewModel: LocationSearchViewModel
	
	@Binding var mapState: MapViewState
	
	let mapView = MKMapView()
	let locationManager = LocationManager.shared
	
	// MARK: Functions
	
	func makeUIView(context: Context) -> some UIView {
		mapView.delegate = context.coordinator
		
		mapView.isRotateEnabled = false
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
		
		return mapView
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		switch mapState {
			case .NO_INPUT:
				context.coordinator.resetMapView()
				break
			case .SEARCHING_FOR_LOCATION:
				break
			case .LOCATION_SELECTED:
				if let selectedLocationCoordinates = locationViewModel.selectedLocation?.cooridate {
					context.coordinator.addAndSelectAnnotation(withCoordinate: selectedLocationCoordinates)
					context.coordinator.configurePolylines(withDestinationCoordinate: selectedLocationCoordinates)
				}
				break
		}
	}
	
	func makeCoordinator() -> MapCoordinator {
		return MapCoordinator(parent: self)
	}
}

// MARK: Extensions

extension MapViewRepresentable {
	
	class MapCoordinator: NSObject, MKMapViewDelegate {
		
		// MARK: Properties
		
		let parent: MapViewRepresentable
		
		var userLocationCoordinate: CLLocationCoordinate2D?
		var currentRegion: MKCoordinateRegion?
		
		// MARK: Constructors
		
		init(parent: MapViewRepresentable) {
			self.parent = parent
			super.init()
		}
		
		// MARK: MKMapViewDelegate
		
		func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
			self.userLocationCoordinate = userLocation.coordinate
			
			let region = MKCoordinateRegion(
				center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
				span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
			
			parent.mapView.setRegion(region, animated: true)
			self.currentRegion = region
		}
		
		func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
			let polylineOverlay = MKPolylineRenderer(overlay: overlay)
			
			polylineOverlay.strokeColor = .systemBlue
			
			return polylineOverlay
		}
		
		// MARK: Helper Functions
		
		func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
			parent.mapView.removeAnnotations(parent.mapView.annotations)
			
			let annotation = MKPointAnnotation()
			
			annotation.coordinate = coordinate
			parent.mapView.addAnnotation(annotation)
			parent.mapView.selectAnnotation(annotation, animated: true)
		}
		
		func configurePolylines(withDestinationCoordinate destinationCoordinate: CLLocationCoordinate2D) {
			guard let userLocationCoordinate = self.userLocationCoordinate else { return }
			
			getDestinationRoute(from: userLocationCoordinate, to: destinationCoordinate) { route in
				self.parent.mapView.addOverlay(route.polyline)
	
				let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 100, left: 64, bottom: 500, right: 64))
				self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
			}
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
				
				completion(route)
			}
		}
		
		func resetMapView() {
			parent.mapView.removeAnnotations(parent.mapView.annotations)
			parent.mapView.removeOverlays(parent.mapView.overlays)
			
			if let currentRegion = currentRegion {
				parent.mapView.setRegion(currentRegion, animated: true)
			}
		}
	}
}
