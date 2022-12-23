//
//  HomeView.swift
//  Uber
//
//  Created by Taha Afzal on 12/18/22.
//

import SwiftUI

struct HomeView: View {
	@State private var showLocationSearchView = false
	
    var body: some View {
		ZStack(alignment: .top) {
			MapViewRepresentable()
				.ignoresSafeArea()
		
			if (showLocationSearchView)
			{
				LocationSearchView(showLocationSearchView: $showLocationSearchView)
			}
			else
			{
				LocationSearchActivationView()
					.padding(.top, 60)
					.onTapGesture {
						withAnimation(.spring()) {
							showLocationSearchView.toggle()
						}
					}
			}
	
			ActionButtonView(isBackArrow: $showLocationSearchView)
				.padding(.leading, 20)
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
