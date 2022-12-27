//
//  HomeView.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import SwiftUI

struct HomeView: View {
	@State private var mapState = MapViewState.NO_INPUT
	@EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
	
    var body: some View {
		VStack {
			ZStack(alignment: .bottom) {
				ZStack(alignment: .top) {
					MapViewRepresentable(mapState: $mapState)
						.ignoresSafeArea()
					
					if mapState == .SEARCHING_FOR_LOCATION
					{
						LocationSearchView(mapState: $mapState)
					}
					else if mapState == .NO_INPUT
					{
						LocationSearchActivationView()
							.padding(.top, 60)
							.onTapGesture {
								withAnimation(.spring()) {
									mapState = .SEARCHING_FOR_LOCATION
								}
							}
					}
					
					ActionButtonView(mapState: $mapState)
						.padding(.leading, 20)
				}
			}
			
			if mapState == .LOCATION_SELECTED {
				RideRequestView()
					.transition(.move(edge: .bottom))
			}
		}
		.onReceive(LocationManager.shared.$userLocation) { location in
			if let location = location {
				locationSearchViewModel.userLocation = location
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
