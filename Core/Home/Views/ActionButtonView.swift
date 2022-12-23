//
//  ActionButtonView.swift
//  Uber
//
//  Created by Taha Afzal on 12/22/22.
//

import SwiftUI

struct ActionButtonView: View {
	@Binding var mapState: MapViewState
	
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
				print("DEBUG: .NO_INPUT")
				break
			case .SEARCHING_FOR_LOCATION:
				mapState = .NO_INPUT
				break
			case .LOCATION_SELECTED:
				mapState = .NO_INPUT
				break
		}
	}
	
	func imageNameForState(state: MapViewState) -> String {
		switch state {
			case .NO_INPUT:
				return "line.3.horizontal"
			case .SEARCHING_FOR_LOCATION, .LOCATION_SELECTED:
				return "arrow.left"
		}
	}
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
		ActionButtonView(mapState: .constant(MapViewState.NO_INPUT))
    }
}
