//
//  RideType.swift
//  Uber
//
//  Created by Taha Afzal on 12/24/22.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
	case X
	case BLACK
	case XL
	
	var id: Int { return rawValue }
	
	var description: String {
		switch self {
			case .X:
				return "UberX"
			case .BLACK:
				return "Uber Black"
			case .XL:
				return "Uber XL"
		}
	}
	
	var imageName: String {
		switch self {
			case .X:
				return "uber-x"
			case .BLACK:
				return "uber-black"
			case .XL:
				return "uber-x"
		}
	}
	
	var baseFare: Double {
		switch self {
			case .X:
				return 5
			case .BLACK:
				return 15
			case .XL:
				return 20
		}
	}
	
	func computePrice(for distanceInMeters: Double) -> Double {
		let distanceInMiles = distanceInMeters / 1600
		
		switch self {
			case .X:
				return (distanceInMiles * 1.5) + baseFare
			case .BLACK:
				return (distanceInMiles * 1.75) + baseFare
			case .XL:
				return (distanceInMiles * 2.0) + baseFare
		}
	}
}
