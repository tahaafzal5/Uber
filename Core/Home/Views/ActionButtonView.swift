//
//  ActionButtonView.swift
//  Uber
//
//  Created by Taha Afzal on 12/22/22.
//

import SwiftUI

struct ActionButtonView: View {
	@Binding var mapState: MapViewState
	
	@EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
	
    var body: some View {
		Button {
			withAnimation(.spring()) {
				actionForState(state: mapState)
			}
		} label: {
			Image(systemName: imageNameForState(state: mapState))
				.foregroundColor(.black)
				.font(.title2)
				.padding()
				.background(.white)
				.clipShape(Circle())
				.shadow(radius: 5)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.disabled(mapState == .NO_INPUT ? true : false)
	}
	
	func actionForState(state: MapViewState) {
		switch state {
			case .NO_INPUT:
				break
			case .SEARCHING_FOR_LOCATION, .LOCATION_SELECTED, .POLYLINE_ADDED:
				mapState = .NO_INPUT
				locationSearchViewModel.selectedLocation = nil
				break
		}
	}
	
	func imageNameForState(state: MapViewState) -> String {
		switch state {
			case .NO_INPUT:
				return "line.3.horizontal"
			case .SEARCHING_FOR_LOCATION, .LOCATION_SELECTED, .POLYLINE_ADDED:
				return "arrow.left"
		}
	}
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
		ActionButtonView(mapState: .constant(MapViewState.NO_INPUT))
    }
}
