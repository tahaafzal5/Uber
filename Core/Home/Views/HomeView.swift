//
//  HomeView.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import SwiftUI

struct HomeView: View {
	@State private var mapState = MapViewState.NO_INPUT
	
    var body: some View {
		ZStack(alignment: .top) {
			MapViewRepresentable()
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
